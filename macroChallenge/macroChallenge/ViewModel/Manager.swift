//
//  Manager.swift
//  macroChallenge
//
//  Created by Barbara Argolo on 30/05/23.
//

import Foundation
import UIKit
import GameKit

struct ButtonImage: Codable {
    var buttonAction: Bool
}

class Manager: NSObject, ObservableObject, UINavigationControllerDelegate {
    
    @Published var inGame = false
    @Published var isGameOver = false
    @Published var authenticationState = PlayerAuthState.authenticating
    @Published var match: GKMatch?
    @Published var buttonState = ButtonImage(buttonAction: false)
    var otherPlayer: GKPlayer?
    var localPlayer = GKLocalPlayer.local
    var isButtonOn = false
    // var playerUUIDKey = UUID().uuidString
    
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
        request.maxPlayers = 2
        
        let matchmakingVC = GKMatchmakerViewController(matchRequest: request)
        matchmakingVC?.matchmakerDelegate = self
        
        rootViewController?.present(matchmakingVC!, animated: true)
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
        //    playerUUIDKey = UUID().uuidString
        
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
    
    //MARK: ENVIA O DADO PARA OS OUTROS JOGADORES
    
    func sendData() {
        do {
            
            buttonState.buttonAction.toggle()
            let data = try JSONEncoder().encode(buttonState)
            try match?.sendData(toAllPlayers: data, with: .reliable)
        } catch {
            print("SEND DATA FAILED")
        }
    }
}
