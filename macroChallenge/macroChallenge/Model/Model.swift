//
//  Model.swift
//  macroChallenge
//
//  Created by Barbara Argolo on 30/05/23.
//

import Foundation
import SwiftUI


//let everydayObjects = ["carol", "barbara", "rebeca", "duda"]  //apagar depois


enum PlayerAuthState: String {
    case authenticating = "Conectando ao Game Center..."
    case unauthenticated = "Por favor, conecte ao Game Center para jogar."
    case authenticated = ""
    
    case error = "Ocorreu um erro ao fazer login no Game Center."
    case restricted = "Você não tem permissão para jogar jogos multiplayer!"
}

struct PastGuess: Identifiable {
    let id = UUID()
    var message: String
}

private struct ScreenSizeKey : EnvironmentKey {
    static let defaultValue: CGSize = .zero
}

extension EnvironmentValues {
    var screenSize: CGSize {
        get { self[ScreenSizeKey.self] }
        set { self[ScreenSizeKey.self] = newValue }
    }
}

