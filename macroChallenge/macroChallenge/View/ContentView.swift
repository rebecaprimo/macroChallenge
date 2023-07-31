//
//  ContentView.swift
//  macroChallenge
//
//  Created by Barbara Argolo on 31/05/23.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @StateObject var matchManager = Manager(viewState: $viewState)
    @State private var viewState: ViewState = .menu

    var themes: [Theme] = Theme.themes // Crie uma instância real do array de temas

    var body: some View {
        ZStack {
            if viewState == .menu {
                MenuView(matchManager: matchManager, viewState: $viewState, themes: themes)
            } else if viewState == .game {
                GameView().environmentObject(matchManager)
            } else if viewState == .themeSelection {
                ThemeView(themes: themes, viewState: $viewState) // Passe a instância real aqui
            } else {
                //ErroJogadorView
            }
        }
        .onAppear {
            matchManager.authenticateUser()
        }
    }
}
