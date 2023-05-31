//
//  MatchManager.swift
//  macroChallenge
//
//  Created by Caroline Stelitano on 29/05/23.
//

import Foundation
import GameKit

//Classe que gerencia os dados das partidas multiplayers
class MatchManager: NSObject, ObservableObject {
    @Published var authenticationState = PlayerAuthState.authenticating
    @Published var inGame = false
    @Published var isGameOver = false
    
    @Published var remainingTime = maxTimeRemaining
    
    var match: GKMatch? //definindo uma partida
    var otherPlayer: GKPlayer?  //definindo o outro jogador
    var localPlayer = GKLocalPlayer.local //definindo jogador atual
    
    var playerUUIKey = UUID().uuidString  //definindo id exclusivo para definir quem começa a partida
    
    //vai trazer as views de match, de authentications   ??NÃO ENTENDI MUITO BEM, mas tudo se completou
    var rootViewController: UIViewController? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }
    
    func authenticateUser(){
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
                    authenticationState = .unauthenticating
                }
            } else {
                authenticationState = .unauthenticating
            }
        }
        
        func startMatchmaking() {
            let request = GKMatchRequest()
            request.minPlayers = 2
            request.maxPlayers = 8
            
            //definir o pedido de request
            let matchmakingVC = GKMatchmakerViewController(matchRequest: request)
            matchmakingVC?.matchmakerDelegate = self
            
            rootViewController?.present(matchmakingVC!, animated: true)
        }
        
        //começar um novo jogo
        func startGame(newMatch: GKMatch) {
            match = newMatch
            match?.delegate = self
            otherPlayer = match?.players.first
            
            sendString("began:\(playerUUIKey)")
        }
    }
}
