//
//  PlayersData.swift
//  macroChallenge
//
//  Created by Barbara Argolo on 30/07/23.
//

import Foundation

class Player {
    let playerID: Int
    var isHost: Bool
    let name: String

    init(playerID: Int, name: String, isHost: Bool) {
        self.playerID = playerID
        self.name = name
        self.isHost = isHost
    }
}
