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
//
//
//      init(viewState: Binding<ViewState>) {
//          self.viewState = viewState.wrappedValue
//          super.init()
//      }

   
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
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 3
        // request.inviteMessage = "Playzinha?"
        
        let matchmakingVC = GKMatchmakerViewController(matchRequest: request)
        matchmakingVC?.matchmakerDelegate = self
        
        rootViewController?.present(matchmakingVC!, animated: true)
        print("cheguei")
    }
    
    func gameOver() {
        isGameOver = true
        gameMatch?.disconnect()
    }
    
    
    func resetGame() {
        DispatchQueue.main.async { [self] in
            isGameOver = false
            inGame = false
        }
        
        gameMatch?.delegate = nil
        gameMatch = nil
        otherPlayer = nil
        
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
    // ...
    
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
    
    // Função para gerar e enviar o numero do host
    
    //passo 1
    func generateAndSendPlayerID() {
        randomHostNumber = Int.random(in: 1...99)
        //nao deixar repetir
        
        let randomNumberString = "$IDPlayer:\(randomHostNumber)"
        print("\(randomNumberString)")
        
        if let data = randomNumberString.data(using: .utf8) {
            //passo 2
            //enviar esse dado para os devices
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
            // Adicionar o novo hostNumber ao histórico hostIDHistory
            playersIDHistory.append(hostNumber)
            
            // Ordenar o histórico hostIDHistory de forma crescente
            playersIDHistory.sort()
            
            if let existingPlayerIndex = players.firstIndex(where: { $0.playerID == hostNumber }) {
                // Atualizar isHost para false para todos os jogadores
                for index in players.indices {
                    players[index].isHost = false
                }
                
                // atualizar isHost para true
                players[existingPlayerIndex].isHost = true
                
                
                // passo 7 - aqui adiciona na estrutura Player que provavelmente irá definir o turno na tela do jogo
            } else {
                let newPlayer = Player(playerID: hostNumber, name: "AAAAAAAAAA", isHost: true, turn: false)
                players.append(newPlayer)
                
                //    print("\(hostID)")
            }
            
            // encontrar o jogador com o maior numero e definir isHost como true
            if let maxHostNumberPlayer = players.max(by: { $0.playerID < $1.playerID }) {
                
                for index in players.indices {
                    players[index].isHost = false
                }
                // definir isHost como true para o jogador com o maior numero
                maxHostNumberPlayer.isHost = true
                
                if playersIDHistory.count == numberOfPlayers {
                    hostIDHistoryComplete = true
                }
                //tem que arrumar a gambiarra do numberOfPlayers
                
                //aqui envia o dado do maior numero do array de playersIDHistory
                
                if playersIDHistory.count == numberOfPlayers {
                    let maxHostID = playersIDHistory.max()!
                    let message = "$MaxPlayerIDDetermined:\(maxHostID)"
                    if let data = message.data(using: .utf8) {
                        sendDataToAllPlayers(data, mode: .reliable)
                    }
                }
                print("historico ids: \(playersIDHistory)")// add o hostID ao historicoo
                // Adicionar o hostID ao histórico
                // tinha que atualizar o nomeeeeeee
                print("o maior número é: \(maxHostNumberPlayer.playerID) e o nome(que nao ta puxando): \(maxHostNumberPlayer.name)")
            }
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
    
    
    
    //MARK: ENVIA O DADO PARA OS OUTROS JOGADORES
    func sendData(buttonId: Int, player: Player) {
        
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
            
            //AQUI PROCESSA O MAIOR NUMERO DOS IDS QUE FOI DEFINIDO NA DETERMINEPLAYERID()
            else if message.hasPrefix("$MaxPlayerIDDetermined:") {
                let hostIDString = message.replacingOccurrences(of: "$MaxPlayerIDDetermined:", with: "")
                
                //                hostIDPublished = hostIDString
                let newState = determineGameView(hostIDString)
                DispatchQueue.main.async { [weak self] in
                    self?.viewState = newState
                }
            } else {
                print("Unable to determine type of message: \(message)")
            }
        } else {
            print("Error decoding data to string.")
        }
    }
}





//MARK: ******* AQUI *********



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
        
        //passo 4 - recebe de outros jogadores
        receivedData(data)
        //vai ter que receber dos outros jogadores o estado dos turnos e se ele é o proximo junto com o estado do botao

        
        do {
            //receberá aqui o botao, turno e id do jogador
            let newData = try JSONDecoder().decode([Int: Bool].self, from: data)
            buttonStates = newData
        } catch {
            print("GAME DATA ERROR")
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
        print("chegaaq")
        
        otherPlayer = invite.sender
        let vc = GKMatchmakerViewController(invite: invite)
        vc?.matchmakerDelegate = self
        vc?.delegate = self
        let rootViewController = UIApplication.shared.delegate?.window?!.rootViewController
        rootViewController?.present(vc!, animated: true)
    }
    
    //AQUI MOSTRA OS JOGADORES QUE RECEBERAM OU ACEITARAM O CONVITE
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFind match: GKMatch) {
        print("chegaaq")
        gameMatch = match
        gameMatch?.delegate = self
        print("Match found, starting game...")
        
        generateAndSendPlayerID()
        
        //de alguma forma, atualizar a view state conforme a funcao
        
        
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
