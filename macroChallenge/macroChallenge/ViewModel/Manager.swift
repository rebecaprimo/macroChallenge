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
    
    @Published var inGame = false
    @Published var isGameOver = false
    @Published var authenticationState = PlayerAuthState.authenticating
    //    @Published var alphabetData = Alphabet(letters: ["A", "B", "C"])
    @Published var match: GKMatch?
    @Published var buttonStates: [Int: Bool] = [:]
    @Published var dataEncoded = DataTest(data: false)
    
    @Published var chooseTheme = false
    @Published var isHost = false
    var randomThemes = Theme.themes
    
    var myGame: GKMatchDelegate?
    var otherPlayers: [GKPlayer]?
    var otherPlayer: GKPlayer?
    var localPlayer = GKLocalPlayer.local
    
    var currentMatchmakerVC: GKTurnBasedMatchmakerViewController?
    
    var playerUUIDKey = UUID().uuidString
    
    var rootViewController: UIViewController? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }
    
    //VERIFICAR SE TÁ USANDO!!!!!
    //    @Published var currentQuestion: String?
    //    @Published var playerResponses: [GKPlayer: String] = [:]
    
    
    
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
        request.minPlayers = 2
        request.maxPlayers = 2
        request.inviteMessage = "Playzinha, bora?"
        
        let matchmakingVC = GKTurnBasedMatchmakerViewController(matchRequest: request)
        matchmakingVC.turnBasedMatchmakerDelegate = self
        
        currentMatchmakerVC = matchmakingVC
        
        rootViewController?.present(matchmakingVC, animated: true)
    }
    
    
    func gameOver() {
        isGameOver = true
        match?.disconnect()
    }
    
    
    func resetGame() {
        DispatchQueue.main.async { [self] in
            isGameOver = false
            inGame = false
            buttonStates = [:]
        }
        
        match?.delegate = nil
        match = nil
        otherPlayer = nil
        playerUUIDKey = UUID().uuidString
        //        currentQuestion = nil
        //        playerResponses.removeAll()
    }
    
    
    //MARK: INICIO DO JOGO
    //fazer logica para ver quem vai ser o antagonista
    
    func startGame(newMatch: GKMatch) -> AnyView {
        match = newMatch
        match?.delegate = self
        otherPlayer = match?.players.first
        otherPlayers = match?.players
        inGame = true
        // sendString("began \(playerUUIDKey)")
        
        
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
    
    //    func startGame(newMatch: GKMatch) -> AnyView {
    //        match = newMatch
    //        match?.delegate = self
    //        otherPlayers = match?.players
    //        inGame = true
    //
    //        //pegar o id dos jogadores
    //        for i in 0..<(otherPlayers?.count ?? 0) {
    //            // se o id do local for maior que o id de algum outro, ele é um agente, ou seja, sai do loop
    //            //display name para mostrar  na tela
    //            if localPlayer.alias > otherPlayers![i].alias {
    //                print("local: \(localPlayer.alias)")
    //                print("other do indice \(i): \(otherPlayers![i].alias)")
    //                break
    //            }
    //
    //            // se for o ultimo elemento do vetor no loop, fala que o local é o antagonista
    //            if i == otherPlayers!.count - 1 {
    //                isHost = true
    //                print("sou o host")
    //                return AnyView(ThemeView(themes: randomThemes))
    //            }
    //        }
    //
    //       // return AnyView(GameView())
    //        return AnyView(Text("Erro"))
    //    }
    
    
    //MARK: ENVIA O DADO PARA OS OUTROS JOGADORES
    func sendData(buttonId: Int) {
        buttonStates[buttonId, default: false].toggle()
        do {
            let data = try JSONEncoder().encode(buttonStates)
            print(buttonStates)
            try match?.sendData(toAllPlayers: data, with: .reliable)
        } catch {
            print("SEND DATA FAILED")
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

extension Manager: GKMatchDelegate {

    //MARK: essa fç executa quando o estado de um dos player muda. 
    func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState) {
        guard state == .disconnected && !isGameOver else { return }
        let alert = UIAlertController(title: "Player disconnected", message: "The other player disconnected from the game.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.match?.disconnect()
        })
        
        DispatchQueue.main.async {
            self.resetGame()
            self.rootViewController?.present(alert, animated: true)
        }
    }
    
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        do {
            let newData = try JSONDecoder().decode([Int: Bool].self, from: data)
            buttonStates = newData
        } catch {
            print("GAME DATA ERROR")
        }
    }
    
    
    //MARK: ******* AQUI *********
    
//    //aqui vc envia uma string na received string
//        func sendString(_ str: String) {
//            guard let encoded = "changeButtonState".data(using: .utf8) else { return }
//            sendData(encoded, mode: .reliable)
//        }
//
    
    //MARK: ******* AQUI *********
    
//        do {
//            try match?.sendData(toAllPlayers: data, with: mode)
//        } catch {
//            print(error)
//        }
//    }
    
}




//MARK: EVENTO PARA BUSCAR A PARTIDA

extension Manager: GKInviteEventListener ,GKLocalPlayerListener, GKTurnBasedMatchmakerViewControllerDelegate {
    
    func player(_ player: GKPlayer, didAccept invite: GKInvite) {
        print("chegaaq")

        otherPlayer = invite.sender
        let vc = GKTurnBasedMatchmakerViewController()
        vc.turnBasedMatchmakerDelegate = self
        vc.delegate = self
        let rootViewController = UIApplication.shared.delegate?.window?!.rootViewController
        rootViewController?.present(vc, animated: true)
    }
    
    func player(_ player: GKPlayer, wantsToQuitMatch match: GKTurnBasedMatch) {
        match.currentParticipant?.matchOutcome = .lost
    }
    
    func player(_ player: GKPlayer, receivedTurnEventFor match: GKTurnBasedMatch, didBecomeActive: Bool) {
        if let vc = currentMatchmakerVC {
            currentMatchmakerVC = nil
            vc.dismiss(animated: true)
        }
        
        guard didBecomeActive else {
            return
        }
        print("receivedTurnEventFor")
    }
    
    
    //AQUI MOSTRA OS JOGADORES QUE RECEBERAM OU ACEITARAM O CONVITE
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFind match: GKMatch) {
        
        //instanciando a classe do GKManagerDelegate
        let manager = Manager()
        print("chegaaq")
        match.delegate = manager
        otherPlayer = match.players.first
           print("Match found, starting game...")
        
//        MARK: entrando direto na tela do jogo:
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
