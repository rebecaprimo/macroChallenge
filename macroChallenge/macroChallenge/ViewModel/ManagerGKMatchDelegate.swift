//
//  ManagerGKMatchDelegate.swift
//  macroChallenge
//
//  Created by Barbara Argolo on 07/06/23.
//

import Foundation
import GameKit


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
    
    //MARK: DECODA A STRUCT
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        do {
            let newData = try JSONDecoder().decode(ButtonImage.self, from: data)
            buttonState = newData
        } catch {
            print("GAME DATA ERROR")
        }
    }
}
