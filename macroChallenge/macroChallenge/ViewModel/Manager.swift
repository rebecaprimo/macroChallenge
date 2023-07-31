//
//  Manager.swift
//  macroChallenge
//
//  Created by Barbara Argolo on 30/05/23.
//

import SwiftUI
import UIKit
import GameKit

struct DataTest: Codable {
    var data: Bool
}

class Manager: NSObject, ObservableObject, UINavigationControllerDelegate {
    
    let minPlayers = 2
    let maxPlayers = 2
    
    @Published var inGame = false
    @Published var isGameOver = false
    @Published var authenticationState = PlayerAuthState.authenticating
    @Published var match: GKTurnBasedMatch?
    @Published var buttonStates: [Int: Bool] = [:]
    @Published var dataEncoded = DataTest(data: false)
    
    @Published var chooseTheme = false
    @Published var isHost = false

    @Published var feedbackMessage: String?

    var randomThemes = Theme.themes
    
    var myGame: GKMatchDelegate?
    var otherPlayers: [GKPlayer]?
    var otherPlayer: GKPlayer?
    var localPlayer = GKLocalPlayer.local
    
    // Pegar participantes da partida
    private var localParticipant: GKTurnBasedParticipant? {
        match?.participants.first{ $0.player == GKLocalPlayer.local }
    }
    
    private var otherParticipant: GKTurnBasedParticipant? {
        guard let localParticipant = localParticipant else { return nil }
        return match?.participants.first{ $0 != localParticipant }
    }
    
    private func otherParticipants() -> [GKTurnBasedParticipant]? {
        guard let localParticipant = localParticipant else { return [] }
        return match?.participants.filter { $0 != localParticipant }
    }

    private var localPlayerIsCurrentParticipant: Bool {
        guard let localParticipant = localParticipant else { return false }
        return match?.currentParticipant == localParticipant
    }
    
    @Published var isCurrentPlayerTurn: Bool = false
    
    private var nextParticipant: GKTurnBasedParticipant? {
        guard let localParticipant = localParticipant else { return nil }
        return localPlayerIsCurrentParticipant ? otherParticipant : localParticipant
    }
    
    //VERIFICAR
//    var currentMatch: GKTurnBasedMatch?
    
    var currentMatchmakerVC: GKTurnBasedMatchmakerViewController?
    
    var playerUUIDKey = UUID().uuidString
    
    var rootViewController: UIViewController? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }
    
    //MARK: AUTENTICANDO USUARIO
    func authenticateUser() {
        GKLocalPlayer.local.authenticateHandler = { [self] vc, e in
            if let viewController = vc {
                rootViewController?.present(viewController, animated: true)
                print("rootAuth")
                return
            }
            
            if let error = e {
                authenticationState = .error
                print(error.localizedDescription)
                
                return
            }
            
            
            if localPlayer.isAuthenticated {
                if localPlayer.isMultiplayerGamingRestricted {
                    authenticationState = .restricted
                } else {
                    authenticationState = .authenticated
                }
            } else {
                authenticationState = .unauthenticated
            }
        }
    }
    
    
    //MARK: PARA ACHAR JOGADORES
    func startMatchmaking() {
        let request = GKMatchRequest()
        request.minPlayers = self.minPlayers
        request.maxPlayers = self.maxPlayers
        request.defaultNumberOfPlayers = 2

        request.inviteMessage = "Playzinha, bora?"
        
        let matchmakingVC = GKTurnBasedMatchmakerViewController(matchRequest: request)
        matchmakingVC.turnBasedMatchmakerDelegate = self
        
        currentMatchmakerVC = matchmakingVC
        
        rootViewController?.present(matchmakingVC, animated: true)
    }
    
    
    // método para ser invocado quando o timer se esgotar
    func gameOver() {
        isGameOver = true
        
        // Verificar se é assim que se termina uma partida definindo que todos perderam.
        // TODO: Excluir o host desse forEach. O host deve ganhar a partida.
        match?.participants.forEach {participant in
            participant.matchOutcome = GKTurnBasedMatch.Outcome.lost
        }
        match?.endMatchInTurn(withMatch: getData()!) { error in
            if (error != nil) {
                print(error!)
            }

            // TODO: Se não houver erro, voltar pra tela anterior
        }
        
        // TODO: Chamar a tela de resultado. Verificar se é melhor escutar o valor de isGameOver ao invés de chamar aqui.
    }
    
    func quitGameDisconnected() {
        print("quitGameDisconnected")
        match?.participants.first { p in
            p.player?.gamePlayerID == localPlayer.gamePlayerID
        }?.matchOutcome = GKTurnBasedMatch.Outcome.quit
        
        match?.endMatchInTurn(withMatch: getData()!) { error in
            if (error != nil) {
                print(error!)
            }

            // TODO: Se não houver erro, voltar pra tela anterior
        }
    }
    
    
    func resetGame() {
        DispatchQueue.main.async { [self] in
            isGameOver = false
            inGame = false
            buttonStates = [:]
        }
        
//        match?.delegate = nil
        match = nil
        otherPlayer = nil
        playerUUIDKey = UUID().uuidString
        //        currentQuestion = nil
        //        playerResponses.removeAll()
    }
    
    
    //MARK: INICIO DO JOGO
    //fazer logica para ver quem vai ser o antagonista
    
    func startGame(newMatch: GKTurnBasedMatch) -> AnyView {
        match = newMatch
//        match?.delegate = self
//        otherPlayer = match?.players.first
//        otherPlayers = match?.players
        inGame = true
        // sendString("began \(playerUUIDKey)")
        
        print("isCurrentPlayerTurn: \(self.localPlayerIsCurrentParticipant)")
        isCurrentPlayerTurn = self.localPlayerIsCurrentParticipant
        
        let isLocalAntagonist = otherPlayers?.contains { localPlayer.alias > $0.alias } == true
        
        if isLocalAntagonist {
            print("local: \(localPlayer.alias)")
            print("sou o antagonista")
            return AnyView(ThemeView(themes: randomThemes))
        } else {
            print("other do indice: \(String(describing: otherPlayers))")
            print("sou o agente")
            return AnyView(Text("Erro"))
        }
    }
    
    private func endTurn(_ gameBoardData: Data, _ originalState: [Int: Bool]) {
        guard let match = match, let nextParticipant = nextParticipant else { return }

        match.endTurn(withNextParticipants: [nextParticipant], turnTimeout: GKTurnTimeoutDefault, match: gameBoardData) {
            error in
            
            if (error == nil) {
                // deu certo
                return
            }
            
            print(error!)
            self.feedbackMessage = error?.localizedDescription
            self.buttonStates = originalState
            
            // "A operação solicitada não pôde ser completada porque o participante especificado não é válido."
            let userInfo = error?._userInfo as? [String:Any]
            if (userInfo?["GKServerStatusCode"] as? Int == 5097) {
                self.quitGameDisconnected()
            }
        }
    }
    
    func getData() -> Data? {
        do {
            print(buttonStates)
            return try JSONEncoder().encode(buttonStates)
        } catch {
            print("SEND DATA FAILED")
            return nil
        }
    }
    
    
    //MARK: ENVIA O DADO PARA OS OUTROS JOGADORES
    func sendData(buttonId: Int) {
        // Salvar estado original pra caso dê erro no envio
        let originalState = buttonStates
        
        buttonStates[buttonId, default: false].toggle()  // Atualiza o estado local do botão.
        let data = getData() // Codifica os dados atualizados em formato JSON.
        if (data != nil) {
            endTurn(data!, originalState)
        }
    }
    

    //MARK: Verifica se todos os botões foram pressionados e se são true (vitóriaGrupo = true)
    func verifyAllButtonsArePressed() {
        let allButtonsAreTrue = buttonStates.allSatisfy({ (key: Int, value: Bool) in
            value == true
        })
        if(buttonStates.count == 21 && allButtonsAreTrue) {
            print("resultado")
            var resultadoJogo = ResultadoJogo(vitoriaGrupo: true)
            ErroJogadorView(resultado: resultadoJogo)
//            self.present(ErroJogadorView, animated: true, completion: nil) NÃO FUNCIONA. não seria na view??
//            NavigationLink(destination: ErroJogadorView(resultado: resultadoJogo)){EmptyView()} NÃO FUNCIONA. não seria na view??
        }
    }
}
    
    
    //MARK: ******* AQUI *********
    //aqui vc chama a send string pois vc esta recebendo uma string
//
//    func receivedString(_ message: String) {
//
//        let messageSplit = message.split(separator: ":")
//        guard let messagePrefix = messageSplit.first?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
//
//        let parameter = String(messageSplit.last?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
//
//        switch messagePrefix {
//        case "began":
//            if playerUUIDKey == parameter {
//                playerUUIDKey = UUID().uuidString
//            //    sendString("began:\(playerUUIDKey)")
//            } else {
//                inGame = true
//            }
//
//
//        case "changeButtonState":
//            // Atualizar o estado do botão com base no parâmetro recebido
//            if parameter == "ON" {
//                // Definir o estado do botão como ON
//                isButtonOn = true
//            } else if parameter == "OFF" {
//                // Definir o estado do botão como OFF
//                isButtonOn = false
//            }
//        default:
//            break
//        }
//    }


//MARK: EVENTOS DA PARTIDA EM ANDAMENTO



//extension Manager: GKMatchDelegate {
//
//    //MARK: essa fç executa quando o estado de um dos player muda.
//    func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState) {
//        guard state == .disconnected && !isGameOver else { return }
//
//        let countActivePlayers = match.players.filter { p in
//            // TODO: filtrar somente players ativos
//            !p.displayName.isEmpty
//        }.count
//
//        if (countActivePlayers >= self.minPlayers) { return }
//
//        // Caso número de jogadores ativos for menor que o mínimo permitido
//        // Desconectar também os jogadores ativos restantes na partida
//        let alert = UIAlertController(title: "Players disconnected", message: "The other players disconnected from the game.", preferredStyle: .alert)
//
//        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
//            self.quitGameDisconnected()
//        })
//
//        DispatchQueue.main.async {
//            self.resetGame()
//            self.rootViewController?.present(alert, animated: true)
//        }
//    }
//
//    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
//        do {
//            let newData = try JSONDecoder().decode([Int: Bool].self, from: data)
//            buttonStates = newData
//        } catch {
//            print("GAME DATA ERROR")
//        }
//    }
//
//
//    //MARK: ******* AQUI *********
//
////    //aqui vc envia uma string na received string
////        func sendString(_ str: String) {
////            guard let encoded = "changeButtonState".data(using: .utf8) else { return }
////            sendData(encoded, mode: .reliable)
////        }
////
//
//    //MARK: ******* AQUI *********
//
////        do {
////            try match?.sendData(toAllPlayers: data, with: mode)
////        } catch {
////            print(error)
////        }
////    }
//
//}




//MARK: EVENTO PARA BUSCAR A PARTIDA

extension Manager: GKInviteEventListener ,GKLocalPlayerListener, GKTurnBasedMatchmakerViewControllerDelegate {
    
    func player(_ player: GKPlayer, didAccept invite: GKInvite) {
        print("player didAccept")

        otherPlayer = invite.sender
        let vc = GKTurnBasedMatchmakerViewController()
        vc.turnBasedMatchmakerDelegate = self
        vc.delegate = self
        let rootViewController = UIApplication.shared.delegate?.window?!.rootViewController
        rootViewController?.present(vc, animated: true)
    }
    
    func player(_ player: GKPlayer, wantsToQuitMatch match: GKTurnBasedMatch) {
        print("player wantsToQuitMatch")
        
        match.currentParticipant?.matchOutcome = .quit
    }
    
    func player(_ player: GKPlayer, receivedTurnEventFor match: GKTurnBasedMatch, didBecomeActive: Bool) {
        print("player receivedTurnEventFor")
        
        if let vc = currentMatchmakerVC {
            currentMatchmakerVC = nil
            vc.dismiss(animated: true)
        }
        
        print("isCurrentPlayerTurn: \(localPlayerIsCurrentParticipant)")
        isCurrentPlayerTurn = localPlayerIsCurrentParticipant
    }
    
    //AQUI MOSTRA OS JOGADORES QUE RECEBERAM OU ACEITARAM O CONVITE
    func turnBasedMatchmakerViewController(_ viewController: GKTurnBasedMatchmakerViewController, didFind match: GKTurnBasedMatch) {
        
        //instanciando a classe do GKManagerDelegate
        let manager = Manager()
        print("Match found, starting game...")
        
//      MARK: entrando direto na tela do jogo:
        viewController.dismiss(animated: true)
        startGame(newMatch: match)
        
//        MARK: entrando na tela do antagonista antes:
//        viewController.dismiss(animated: true)
//        let gameView = manager.startGame(newMatch: match)
//
//           DispatchQueue.main.async {
//               if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//                  let delegate = windowScene.delegate as? UIWindowSceneDelegate,
//                  let window = delegate.window {
//                   window?.rootViewController = UIHostingController(rootView: gameView)
//               }
//           }
       }
    
    func turnBasedMatchmakerViewControllerWasCancelled(_ viewController: GKTurnBasedMatchmakerViewController) {
        viewController.dismiss(animated: true)
    }
    
    func turnBasedMatchmakerViewController(_ viewController: GKTurnBasedMatchmakerViewController, didFailWithError error: Error) {
        print("Matchmaker vc did fail with error: \(error.localizedDescription).")
    }
}
