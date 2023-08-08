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
    var resultado : ResultadoJogo?
    var textDesafio : String = ""
    var horarios : [Int] = []
    
    @Published var viewState: ViewState = .menu

    @Published var players: [Player] = []
    var hostIDHistoryComplete: Bool = false
    var playersIDHistory: [Int] = []
    var randomThemes = Theme.themes
    
    private var randomHostNumber: Int = 0
    
    var isBombMasterAssigned = false
    var myGame: GKMatchDelegate?
    var agents: [GKPlayer]?
    var otherPlayer: GKPlayer?
    var localPlayer = GKLocalPlayer.local
    
    //armazena todos os jogadores e retorna quantos estao na partida
    var numberOfPlayers: Int = 2
    
    
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
        request.maxPlayers = 2
        request.inviteMessage = "Playzinha?"
        
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
        horarios.removeAll()
    }
    
    
    //MARK: INICIO DO JOGO
    
    func startGame(newMatch: GKMatch) {
//        gameMatch = newMatch
//        gameMatch?.delegate = self
//        otherPlayer = gameMatch?.players.first
        inGame = true
      //  viewState = .game
        
        print("cheguei na funcao startgame")
        
    }
    
    //VERIFICAR NECESSIDADE DA DETERMINEGAMEVIEW()
    //passo 8 - determinando a view para os jogadores, todos estao indo direto para a do jogo
    func determineGameView(_ hostID: String) -> ViewState {
        print("\(hostID)")
        print("numero de jogadores no total: \(numberOfPlayers)")
        
        //nesse for, é bom sempre olhar para ver se, os jogadores foram adicionados corretamente ex:
//        exemplo do print
//        ID do jogador: 90
//        ID do jogador: 2
        for player in players {
            print("ID do jogador: \(player.playerID)")
        }
        
        var newViewState: ViewState = .waitingRoom
            
            if let hostID = Int(hostID) {
                if let playerWithMaxHostID = players.first(where: { $0.playerID == hostID }) {
                    if playerWithMaxHostID.playerID == hostID {
                        if !isBombMasterAssigned {
                            print("CAI NO HOST: \(hostID)")
                            isBombMasterAssigned = true
                            newViewState = .game
                            print("newViewStateHost: \(newViewState)")
                        } else {
                            print("CAI NO AGENTE")
                            newViewState = .game
                            print("newViewStateAgent: \(newViewState)")
                            
                        }
                    } else {
                        newViewState = .waitingRoom
                    }
                }
            }
          return newViewState
        }
    

    // MARK: JOGO
    
    //passo 1 - Função para gerar e enviar o numero do ID
    func generateAndSendPlayerID() {
        randomHostNumber = Int.random(in: 1...999_999)
        let randomNumberString = "$IDPlayer:\(randomHostNumber)"
        
        if let data = randomNumberString.data(using: .utf8) {
            sendDataToAllPlayers(data, mode: .reliable)
        } else {
            print("erro ")
        }
    }
    
    
    //passo 6 - função para determinar e adicionar os jogadores
    func determineOrderPlayers(_ dataString: String) {
        let hostNumberString = dataString.replacingOccurrences(of: "$IDPlayer:", with: "")
        print("host number string: \(hostNumberString)")
        
        if let hostNumber = Int(hostNumberString) {
            playersIDHistory.append(hostNumber)
            
            if ((gameMatch?.players.count)! + 1 == playersIDHistory.count) {
                let maxHostID = playersIDHistory.max()!
                if (randomHostNumber == maxHostID) {
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
    
    // cada player manda o seu horario local
    func sendDataHorarioInicial() {
        let horarioAtual = pegarHorarioAtual()
        horarios.append(horarioAtual)
        let dict = ["tipo" : "horarioInicial",
                    "horario" : "\(horarioAtual)"]
        print("sending horario inicial")
        
        do {
            let data = try JSONEncoder().encode(dict)
            print(data)
            try gameMatch?.sendData(toAllPlayers: data, with: .reliable)
            //try gameMatch?.sendData(toAllPlayers: messageData, with: mode)
        } catch {
            print("SEND DATA Horario Inicial FAILED")
        }
    }
    
    
    //MARK: ENVIA O DADO PARA OS OUTROS JOGADORES
    func sendData(buttonId: Int) {
        //enviar turno do jogador e o id dele
        buttonStates[buttonId, default: false].toggle()
        do {
            let data = try JSONEncoder().encode(buttonStates)
            print(buttonStates)
            try gameMatch?.sendData(toAllPlayers: data, with: .reliable)
        } catch {
            print("SEND DATA FAILED")
        }
    }
    
    //MARK: RECEBER DADOS
    // Função para processar os dados recebidos
    func receivedData(_ data: Data) {
        // passo 5 - recebe o dado do id do player
        if let message = String(data: data, encoding: .utf8) {
            if message.hasPrefix("$IDPlayer:") {
                print("\(message)")
                determineOrderPlayers(message)
            }
            //VERIFICAR NECESSIDADE DESSE TRECHO DO CÓDIGO
//            //AQUI PROCESSA O MAIOR NUMERO DOS IDS QUE FOI DEFINIDO NA DETERMINEPLAYERID()
//            else if message.hasPrefix("$MaxPlayerIDDetermined:") {
//                print("$MaxPlayerIDDetermined")
//                let hostIDString = message.replacingOccurrences(of: "$MaxPlayerIDDetermined:", with: "")
//
//                //                hostIDPublished = hostIDString
//                let newState = determineGameView(hostIDString)
//                DispatchQueue.main.async { [weak self] in
//                    self?.viewState = newState
//                }
//            } else {
//                print("Unable to determine type of message: \(message)")
//            }
        } else {
            print("Error decoding data to string.")
        }
    }
         
//    MARK: funções para calcular horários para id da partida
    func pegarHorarioAtual() -> Int {
        return Int(Date().timeIntervalSince1970*1_000_000)
    }

    func calcularElementoPorHorarios(_ horarios: [Int], _ array: [Any]) -> Any {
        var sum = 0
        for horario in horarios {
            sum += horario
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
        guard state == .disconnected && !isGameOver else { return }
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
        //passo 4 - recebe de outros jogadores
        receivedData(data)
        //vai ter que receber dos outros jogadores o estado dos turnos e se ele é o proximo junto com o estado do botao
        print("viewState: \(self.viewState)")
        
        do {
            print("receiving data")
            let newData = try JSONDecoder().decode([String : String].self, from: data)
            if (newData["tipo"] == "resultado") {
                let vitoria = Bool(newData["vitoriaGrupo"]!)!
                gameOver()
                navegarParaResultadoJogoView(vitoriaGrupo: vitoria)
            } else if (newData["tipo"] == "horarioInicial") {
                let horario = Int(newData["horario"]!)!
                horarios.append(horario)
                print(horario)
                if (match.players.count + 1 == horarios.count) {
                    currentTheme = calcularElementoPorHorarios(horarios, Theme.themes) as? Theme
                    textDesafio = calcularElementoPorHorarios(horarios, ResultadoJogo.desafios) as! String
                }
            }
        } catch {
            print("GAME DATA ERROR receivedDataCarol")
        }
        
        do {
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
        sendDataHorarioInicial()
    }
    
    //AQUI MOSTRA OS JOGADORES QUE RECEBERAM OU ACEITARAM O CONVITE
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFind match: GKMatch) {
        print("matchmakerViewController didFind")
        print("viewState: \(self.viewState)")
        gameMatch = match
        gameMatch?.delegate = self
        print("Match found, starting game...")
        sendDataHorarioInicial()
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
