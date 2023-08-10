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
    @Published var gameMatch: GKMatch?
    @Published var buttonStates: [Int: Bool] = [:]
    @Published var dataEncoded = DataTest(data: false)
    @Published var currentTheme: Theme?
    @Published var hostIDPublished = String()
    @Published var menuSheetContent: AnyView?
    @Published var showMenuSheet = false
    @Published var viewState: ViewState = .menu
    @Published var players: [Player] = []
    @Published var MaxIDGame: Int = 0
    @Published var isHost: Bool = false
    private var randomHostNumber: Int = 0
    var resultado : ResultadoJogo?
    var textDesafio : String = ""
    var playersIDHistory: [Int] = []
    var randomThemes = Theme.themes
    var myGame: GKMatchDelegate?
    var otherPlayer: GKPlayer?
    var localPlayer = GKLocalPlayer.local
    
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
        resetGame()
        
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 3
        // request.inviteMessage = "Playzinha?"
        
        let matchmakingVC = GKMatchmakerViewController(matchRequest: request)
        matchmakingVC?.matchmakerDelegate = self
        
        rootViewController?.present(matchmakingVC!, animated: true)
        print("cheguei startMatchMaking")
    }
    
    func gameOver() {
        isGameOver = true
        gameMatch?.disconnect()
        gameMatch?.delegate = nil
    }
    
    
    func resetGame() {
        DispatchQueue.main.async { [self] in
            isGameOver = false
            inGame = false
        }
        gameMatch?.delegate = nil
        gameMatch = nil
        otherPlayer = nil
        buttonStates.removeAll()
        playersIDHistory.removeAll()
    }
    
    
    //MARK: INICIO DO JOGO
    //
    //    func startGame(newMatch: GKMatch) {
    //        inGame = true
    //        print("cheguei na funcao startgame")
    //    }
    
    // MARK: JOGO
    
    
    func determineOrderPlayers(_ dataString: String) {
        let hostNumberString = dataString.replacingOccurrences(of: "$IDPlayer:", with: "")
        print("host number string: \(hostNumberString)")
        
        if let hostNumber = Int(hostNumberString) {
            playersIDHistory.append(hostNumber)
            
            if ((gameMatch?.players.count)! + 1 == playersIDHistory.count) {
                textDesafio = calcularElementoPorIDs(playersIDHistory, ResultadoJogo.desafios) as! String
                let maxHostID = playersIDHistory.max()!
                if (randomHostNumber == maxHostID) {
                    isHost = true
                    DispatchQueue.main.async { [weak self] in
                        self?.viewState = .themeSelection
                    }
                } else {
                    DispatchQueue.main.async { [weak self] in
                        self?.viewState = .waitingRoom
                    }
                }
            }
        }
    }
    
    func determineGameView() {
        DispatchQueue.main.async { [weak self] in
            self?.viewState = .game
        }
    }
    
    
    //MARK: Verifica se todos os botões foram pressionados e se são true (vitóriaGrupo = true)
    func verifyAllButtonsArePressed() {
        let allButtonsAreTrue = buttonStates.allSatisfy({ (key: Int, value: Bool) in
            value == true
        })
        print(buttonStates.count)
        if(buttonStates.count == 21 && allButtonsAreTrue) {
            print("resultado")
            sendDataResultadoJogo(vitoriaGrupo: true)
            gameOver()
            navegarParaResultadoJogoView(vitoriaGrupo: true)
        }
    }
    
    //chama a tela de resultado
    func navegarParaResultadoJogoView(vitoriaGrupo : Bool) {
        resultado = ResultadoJogo(vitoriaGrupo: vitoriaGrupo, textDesafio: textDesafio)
        DispatchQueue.main.async { [weak self] in
            self?.viewState = .result
        }
    }
    
    //MARK: ENVIA O DADO PARA OS OUTROS JOGADORES
    
    //envia dados de resultado para o Game Center
    func sendDataResultadoJogo(vitoriaGrupo : Bool) {
        let dict = ["tipo" : "resultado",
                    "vitoriaGrupo" : "\(vitoriaGrupo)"]
        
        do {
            let data = try JSONEncoder().encode(dict)
            print(data)
            try gameMatch?.sendData(toAllPlayers: data, with: .reliable)
        } catch {
            print("SEND DATA RESULTADO JOGO FAILED")
        }
    }
    
    func generateAndSendPlayerID() {
        randomHostNumber = Int.random(in: 1...999_999)
        let randomNumberString = "$IDPlayer:\(randomHostNumber)"
        
        if let data = randomNumberString.data(using: .utf8) {
            sendDataToAllPlayers(data, mode: .reliable)
        } else {
            print("erro ")
        }
    }
    
    func sendData(buttonId: Int) {

        buttonStates[buttonId, default: false].toggle()
        do {
            let data = try JSONEncoder().encode(buttonStates)
            print(buttonStates)
            try gameMatch?.sendData(toAllPlayers: data, with: .reliable)
        } catch {
            print("SEND BUTTONDATA FAILED")
        }
    }
    
    func sendDataTheme(){
        let dict = ["tipo" : "tema",
                    "tema" : "\(currentTheme!.name)"]
        
        do {
            let data = try JSONEncoder().encode(dict)
            try gameMatch?.sendData(toAllPlayers: data, with: .reliable)
        } catch {
            print("SEND THEMEDATA FAILED")
        }
        
    }
    
    func onThemePicked(_ theme: String) {
        currentTheme = Theme.themes.first (where: { t in
            return t.name == theme
        })
        
        sendDataTheme()
        determineGameView()
    }
    
    //MARK: RECEBER DADOS
    
    func receivedData(_ data: Data) {
        if let message = String(data: data, encoding: .utf8) {
            if message.hasPrefix("$IDPlayer:") {
                print("\(message)")
                determineOrderPlayers(message)
            }
        } else {
            print("Error decoding data to string.")
        }
    }
    
    func calcularElementoPorIDs(_ ids: [Int], _ array: [Any]) -> Any {
        var sum = 0
        for id in ids {
            sum += id
        }
        
        let indice = sum % array.count
        return array[indice]
    }
    
    //MARK: função de timer encerrado
    func endTimer() {
        gameOver()
        navegarParaResultadoJogoView(vitoriaGrupo: false)
    }
}

//MARK: EVENTOS DA PARTIDA EM ANDAMENTO

extension Manager: GKMatchDelegate {
    
    func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState) {
        guard state == .disconnected else { return }
        let alert = UIAlertController(title: "Player disconnected", message: "The other player disconnected from the game.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.gameMatch?.disconnect()
        })
        
        DispatchQueue.main.async {
            self.resetGame()
            self.rootViewController?.present(alert, animated: true)
        }
    }
    
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        print("didReceive")
        print("viewState: \(self.viewState)")
        receivedData(data)
        print("viewState: \(self.viewState)")
        
        do {
            print("receiving data")
            let newData = try JSONDecoder().decode([String : String].self, from: data)
            if (newData["tipo"] == "resultado") {
                let vitoria = Bool(newData["vitoriaGrupo"]!)!
                gameOver()
                navegarParaResultadoJogoView(vitoriaGrupo: vitoria)
                return
            } else if (newData["tipo"] == "tema") {
                currentTheme = Theme.themes.first (where: { t in
                    return t.name == newData["tema"]
                })
                determineGameView()
                return
            }
        } catch {
            print("GAME DATA ERROR receivedDataCarol")
        }
        
        do {
            //receberá aqui o botao, turno e id do jogador
            let newData = try JSONDecoder().decode([Int: Bool].self, from: data)
            buttonStates = newData
        } catch {
            print("GAME DATA ERROR receivedData")
        }
    }
    
    func sendDataToAllPlayers(_ messageData: Data, mode: GKMatch.SendDataMode) {
        
        do {
            try gameMatch?.sendData(toAllPlayers: messageData, with: mode)
            //passo 4 - processar os dados enviados também localmente
            receivedData(messageData)
            //onde o jogador local manda o seu estado de turno
        } catch {
            print(error)
        }
    }
}



//MARK: EVENTO PARA BUSCAR A PARTIDA

extension Manager: GKInviteEventListener ,GKLocalPlayerListener, GKMatchmakerViewControllerDelegate {
    
    func player(_ player: GKPlayer, didAccept invite: GKInvite) {
        print("player didAccept")
        
        otherPlayer = invite.sender
        let vc = GKMatchmakerViewController(invite: invite)
        vc?.matchmakerDelegate = self
        vc?.delegate = self
        let rootViewController = UIApplication.shared.delegate?.window?!.rootViewController
        rootViewController?.present(vc!, animated: true)
        generateAndSendPlayerID()
    }
    
    //AQUI MOSTRA OS JOGADORES QUE RECEBERAM OU ACEITARAM O CONVITE
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFind match: GKMatch) {
        print("matchmakerViewController didFind")
        print("viewState: \(self.viewState)")
        gameMatch = match
        gameMatch?.delegate = self
        print("Match found, starting game...")
        generateAndSendPlayerID()
        
        viewController.dismiss(animated: true)
        //   startGame(newMatch: match)
    }
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        viewController.dismiss(animated: true)
    }
    
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        viewController.dismiss(animated: true)
    }
}
