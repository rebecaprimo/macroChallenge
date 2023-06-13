//
//  Manager.swift
//  macroChallenge
//
//  Created by Barbara Argolo on 30/05/23.
//

import Foundation
import UIKit
import GameKit

struct DataTest: Codable {
    var data: Bool
}

class Manager: NSObject, ObservableObject, UINavigationControllerDelegate {

    @Published var inGame = false
    @Published var isGameOver = false
    @Published var authenticationState = PlayerAuthState.authenticating
    @Published var alphabetData = Alphabet(letters: ["A", "B", "C"])
    @Published var match: GKMatch?
    
    @Published var dataA = DataTest(data: false)


    var myGame: GKMatchDelegate?
    var otherPlayer: GKPlayer?
    var localPlayer = GKLocalPlayer.local
    var isButtonOn = false
    
    var playerUUIDKey = UUID().uuidString
    
    var rootViewController: UIViewController? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }
    
    @Published var currentQuestion: String?
    
    @Published var playerResponses: [GKPlayer: String] = [:]
    

    
    //autenticando usuario
    
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
        playerUUIDKey = UUID().uuidString
        currentQuestion = nil
        playerResponses.removeAll()
    }

    
    //MARK: INICIO DO JOGO
    //fazer logica para ver quem vai ser o antagonista
    func startGame(newMatch: GKMatch) {
        match = newMatch
        match?.delegate = self
        otherPlayer = match?.players.first
        inGame = true
       // sendString("began \(playerUUIDKey)")
        
    }
    
    func sendData() {
        do {
            
            dataA.data.toggle()
            let data = try JSONEncoder().encode(dataA)
            try match?.sendData(toAllPlayers: data, with: .reliable)
        } catch {
            print("SEND DATA FAILED")
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
}


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
        do {
            let newData = try JSONDecoder().decode(DataTest.self, from: data)
            dataA = newData
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
        let manager = Manager()
        print("chegaaq")
        match.delegate = manager
        otherPlayer = match.players.first
           print("Match found, starting game...")
        
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
