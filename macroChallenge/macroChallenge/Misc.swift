//
//  Misc.swift
//  macroChallenge
//
//  Created by rebeca primo on 29/05/23.
//

import Foundation

let everydayObjects = ["Coisas que tem em casa", "a", "b"]

enum PlayerAuthState: String {
    case authenticating = "Entrando no Game Center..."
    case unauthenticated = "Por favor, entre no Game Center para jogar."
    case authenticated = ""
    
    case error = "Opa! Houve algum erro para entrar no Game Center."
    case restricted = "Você não tem permissão para jogar em multiplayer."
}

let maxTimeRemaining = 150

struct PastGuess: Identifiable {
    let id = UUID()
    var message: String
}
