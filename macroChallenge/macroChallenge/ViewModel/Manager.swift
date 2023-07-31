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
    @Published var match: GKMatch?
    @Published var buttonStates: [Int: Bool] = [:]
    @Published var dataEncoded = DataTest(data: false)
    @Published var currentTheme: Theme?
    //   @Published var hasMatch = false
    @Published var isBombMasterAssigned = false
    @Published var menuSheetContent: AnyView?
    @Published var showMenuSheet = false
    @Published var hostIDPublished: String = ""
    
    @Binding var viewState: ViewState
    
    init(viewState: Binding<ViewState>) {
        _viewState = viewState
    }

  
    
    
    //   @Published var hasFoundHost = false
    
    @Published var players: [Player] = []
    //  @Published var hostID: Int = 0
    var hostIDHistoryComplete: Bool = false
    var hostIDHistory: [Int] = []
    var randomThemes = Theme.themes
    
    private var randomHostNumber: Int = 0
    
    var myGame: GKMatchDelegate?
    var agents: [GKPlayer]?
    var otherPlayer: GKPlayer?
    var localPlayer = GKLocalPlayer.local
    
    //armazena todos os jogadores e retorna quantos estao na partida
    var numberOfPlayers: Int = 3
    
    
    
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
        request.maxPlayers = 3
       // request.inviteMessage = "Playzinha?"
        
        let matchmakingVC = GKMatchmakerViewController(matchRequest: request)
        matchmakingVC?.matchmakerDelegate = self
        
        rootViewController?.present(matchmakingVC!, animated: true)
        print("cheguei")
    }
    
    func gameOver() {
        isGameOver = true
        match?.disconnect()
    }
    
    
    func resetGame() {
        DispatchQueue.main.async { [self] in
            isGameOver = false
            inGame = false
        }
        
        match?.delegate = nil
        match = nil
        otherPlayer = nil
//        currentQuestion = nil
//        playerResponses.removeAll()
    }

    
    //MARK: INICIO DO JOGO

    
    
    func startGame(newMatch: GKMatch) {
        match = newMatch
        match?.delegate = self
        otherPlayer = match?.players.first
    //    otherPlayers = match?.players
        inGame = true
        // sendString("began \(playerUUIDKey)")
       
//        let isLocalAntagonist = otherPlayers?.contains { localPlayer.alias > $0.alias } == true
//
//        if isLocalAntagonist {
//            print("local: \(localPlayer.alias)")
//            print("sou o antagonista")
//            // Seu código para o antagonista aqui
//        } else {
//            print("other do indice: \(String(describing: otherPlayers))")
//            print("sou o agente")
//            // Seu código para o agente aqui
//        }
    }
    // ...
    
    
    
    func determineMenuSheetContent(_ hostID: String) -> ViewState {
            print("numero de jogadores no total: (numberOfPlayers)")
            for player in players {
                print("ID do jogador: (player.playerID)")
            }
            showMenuSheet = true

            hostIDPublished = hostID


            if let hostID = Int(hostID) {
                if let playerWithMaxHostID = players.first(where: { $0.playerID == hostID }) {
                    if playerWithMaxHostID.playerID == hostID {
                        if !isBombMasterAssigned {
                            print("o host caiu na bomb: (hostID)")
                            isBombMasterAssigned = true
                            return .themeSelection
                        } else {
                            return .waitingRoom
                        }
                    } else {
                        return .waitingRoom 
                    }
                }
            }
            return .menu
        }

     // MARK: JOGO
     
     // Função para gerar e enviar o numero do host
     func generateAndSendHostNumber() {
         randomHostNumber = Int.random(in: 1...99)
         //nao deixar repetir
         let randomNumberString = "$Host:\(randomHostNumber)"
         print("\(randomNumberString)")
         
         if let data = randomNumberString.data(using: .utf8) {
             sendDataToAllPlayers(data, mode: .reliable)
         } else {
             print("erro ")
         }
     }
     
     //Função para determinar o Host
     
     func determineHost(_ dataString: String) {
         let hostNumberString = dataString.replacingOccurrences(of: "$Host:", with: "")
         print("host number string: \(hostNumberString)")
         
         if let hostNumber = Int(hostNumberString) {
                     // Adicionar o novo hostNumber ao histórico hostIDHistory
                     hostIDHistory.append(hostNumber)

                     // Ordenar o histórico hostIDHistory de forma crescente
                     hostIDHistory.sort()
                 
             if let existingPlayerIndex = players.firstIndex(where: { $0.playerID == hostNumber }) {
                 // Atualizar isHost para false para todos os jogadores
                 for index in players.indices {
                     players[index].isHost = false
                 }
                 
                 // atualizar isHost para true
                 players[existingPlayerIndex].isHost = true
      
             } else {
                 let newPlayer = Player(playerID: hostNumber, name: "AAAAAAAAAA", isHost: true)
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
                 
                 if hostIDHistory.count == numberOfPlayers {
                      hostIDHistoryComplete = true
                  }
                 if hostIDHistory.count == numberOfPlayers {
                     let maxHostID = hostIDHistory.max()!
                     let message = "$HostIDDetermined:\(maxHostID)"
                     if let data = message.data(using: .utf8) {
                         sendDataToAllPlayers(data, mode: .reliable)
                     }
                 }
                 print("historico ids: \(hostIDHistory)")// Adicionar o hostID ao histórico
 // Adicionar o hostID ao histórico
 // tinha que atualizar o nomeeeeeee
                 print("o maior número que sera o host: \(maxHostNumberPlayer.playerID) e o nome: \(maxHostNumberPlayer.name)")
             }
         }
     }
    
    

    
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
    
    //MARK: RECEBER DADOS
    // Função para processar os dados recebidos
    func receivedData(_ data: Data) {
        if let message = String(data: data, encoding: .utf8) {
            if message.hasPrefix("$Host:") {
                print("\(message)")
                determineHost(message)
            }
            else if message.hasPrefix("$HostIDDetermined:") {
                let hostIDString = message.replacingOccurrences(of: "$HostIDDetermined:", with: "")
                _ = determineMenuSheetContent(hostIDString)
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
            self.match?.disconnect()
        })
        
        DispatchQueue.main.async {
            self.resetGame()
            self.rootViewController?.present(alert, animated: true)
        }
    }
    
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        
        
        receivedData(data)
        
        do {
            let newData = try JSONDecoder().decode([Int: Bool].self, from: data)
            buttonStates = newData
        } catch {
            print("GAME DATA ERROR")
        }
    }
    
        
        func sendDataToAllPlayers(_ messageData: Data, mode: GKMatch.SendDataMode) {
            
            do {
                try match?.sendData(toAllPlayers: messageData, with: mode)
                
                // Processar os dados enviados também localmente
                receivedData(messageData)
                
                
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
        
        //instanciando a classe do GKManagerDelegate
        let manager = Manager(viewState: $viewState)
        print("chegaaq")
        match.delegate = manager
        otherPlayer = match.players.first
           print("Match found, starting game...")
        
        generateAndSendHostNumber()
        
        //chama view state
        
        
           viewController.dismiss(animated: true)
           startGame(newMatch: match)
       }
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        viewController.dismiss(animated: true)
    }
    
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        viewController.dismiss(animated: true)
    }
}
