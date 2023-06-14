//
//  ManagerGKMatchVCDelegate.swift
//  macroChallenge
//
//  Created by Barbara Argolo on 07/06/23.
//

import Foundation
import GameKit


//MARK: EVENTO PARA BUSCAR A PARTIDA

extension Manager: GKMatchmakerViewControllerDelegate {
    
    
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
