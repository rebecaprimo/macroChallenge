//
//  MatchManager+GKMatchDelegate.swift
//  macroChallenge
//
//  Created by rebeca primo on 29/05/23.
//

import Foundation
import GameKit

extension MatchManager: GKMatchDelegate {
//    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
//        <#code#>
//    }
    
    func sendData(_ data: Data, mode: GKMatch.SendDataMode) {
        do {
            try match?.sendData(toAllPlayers: data, with: mode)
        } catch {
            print(error)
        }
    }
}
