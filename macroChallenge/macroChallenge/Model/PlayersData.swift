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
    var turn: Bool

    init(playerID: Int, name: String, isHost: Bool, turn: Bool) {
        self.playerID = playerID
        self.name = name
        self.isHost = isHost
        self.turn = turn
    }
}
