//
//  Auth.swift
//  macroChallenge
//
//  Created by Caroline Stelitano on 29/05/23.
//

import Foundation

// Autenticações do usuário
enum PlayerAuthState: String {
    case authenticating = "Logging into Game Center"
    case unauthenticating = "Please, sign in to Game Center to play."
    case authenticated = ""
    
    case error = "Error logging into Game Center."
    case restricted = "You're not allowed to play multiplayer games."
}


let maxTimeRemaining = 150
