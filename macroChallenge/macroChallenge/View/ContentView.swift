//
//  ContentView.swift
//  macroChallenge
//
//  Created by Barbara Argolo on 31/05/23.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var manager: Manager
    @State private var viewState: ViewState = .menu
    var themes: [Theme] = Theme.themes
    
    var body: some View {
        ZStack {
            if viewState == .menu {
                MenuView(viewState: $viewState, themes: themes)
            } else if viewState == .game {
                GameView(viewState: $viewState).environmentObject(manager)
            } else if viewState == .themeSelection {
                ThemeView(themes: themes, viewState: $viewState).environmentObject(manager) // Injete o Manager aqui

            } else if viewState == .waitingRoom {
                AgentsView()
            } else if viewState == .result {
                ResultadoJogoView(resultado: manager.resultado!)
            } else {
                Text("Erro")
            }
        }
        .onAppear {
            manager.authenticateUser()
        }
        .onChange(of: manager.viewState) { newState in
            viewState = newState
        }
    }
}
