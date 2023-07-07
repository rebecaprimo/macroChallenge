//
//  macroChallengeApp.swift
//  macroChallenge
//
//  Created by rebeca primo on 22/05/23.
//

import SwiftUI

@main
struct macroChallengeApp: App {
    @StateObject var matchManager = Manager()
    var randomThemes = Theme.themes
    
    var body: some Scene {
        WindowGroup {
//            ErroJogadorView()
//            let resultadoJogo = ResultadoJogo(vitoriaGrupo: false)
//            ErroJogadorView(resultado: resultadoJogo)
//           ContentView(matchManager: matchManager)
            ThemeView(themes: randomThemes)
        }
    }
}
