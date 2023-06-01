//
//  Manager.swift
//  macroChallenge
//
//  Created by Barbara Argolo on 30/05/23.
//

import Foundation
import GameKit

class Manager: NSObject, ObservableObject, UINavigationControllerDelegate {

    @Published var inGame = false
    @Published var isGameOver = false
    @Published var authenticationState = PlayerAuthState.authenticating
    private var hasSentQuestion = false
    @Published var pastGuesses = [PastGuess]()
  //  @Published var isHost = false
    var match: GKMatch?
    var myGame: GKMatchDelegate?
    var corePlayer: GKPlayer?
    var otherPlayer: GKPlayer?
    var ma: GKMatch?
    var localPlayer = GKLocalPlayer.local
    
    var playerUUIDKey = UUID().uuidString
    
    var rootViewController: UIViewController? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }
    
    @Published var currentQuestion: String?
    
    @Published var playerResponses: [GKPlayer: String] = [:]
    

    
    //autenticando usuario
    
    func authenticateUser() {
        GKLocalPlayer.local.authenticateHandler = { [self] vc, e in
            if let viewController = vc {
                rootViewController?.present(viewController, animated: true)
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
    
    
    //para achar jogadores
    func startMatchmaking() {
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 2
        request.inviteMessage = "Playzinha?"
        
        let matchmakingVC = GKMatchmakerViewController(matchRequest: request)
        matchmakingVC?.matchmakerDelegate = self
        
        rootViewController?.present(matchmakingVC!, animated: true)
        print("chega aq")
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
        
        hasSentQuestion = false
        match?.delegate = nil
        match = nil
        otherPlayer = nil
        pastGuesses.removeAll()
        playerUUIDKey = UUID().uuidString
        currentQuestion = nil
        playerResponses.removeAll()
    }

    //fazer logica para ver quem vai ser o antagonista
    func startGame(newMatch: GKMatch) {
        match = newMatch
        match?.delegate = self
        otherPlayer = match?.players.first
        inGame = true
        sendString("began \(playerUUIDKey)")
        
    }
    
    func receivedString(_ message: String) {
        let messageSplit = message.split(separator: ":")
        guard let messagePrefix = messageSplit.first?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        
        let parameter = String(messageSplit.last?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
        
        switch messagePrefix {
        case "began":
            if playerUUIDKey == parameter {
                playerUUIDKey = UUID().uuidString
                sendString("began:\(playerUUIDKey)")
            } else {
                inGame = true
            }
        default:
            break
        }
    }
}



extension Manager: GKMatchDelegate {
    
    
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
//        match = match
        match.delegate = self
        let decoded = String(data: data, encoding: String.Encoding.utf8)
        print("recebi \(String(describing: decoded))", "\(player)")
        
//        if let message = String(data: data, encoding: .utf8) {
//            if message.hasPrefix("strData:") {
//                let messageContent = message.replacingOccurrences(of: "strData:", with: "")
//            }
//        }
    }
    
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
    
    //
    func sendString(_ message: String) {
         let encoded = "strData:\(message)".data(using: .utf8)
        if corePlayer != nil {
            try? ma?.sendData(toAllPlayers: encoded!, with: GKMatch.SendDataMode.reliable)
        }
            
        
//        { return }
//        sendData(encoded, mode: .reliable)
    }
    
    
    func sendData(_ data: Data, mode: GKMatch.SendDataMode) {
        do {
            try match?.sendData(toAllPlayers: data, with: mode)
        } catch {
            print(error)
        }
    }
}


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

                       
                            

