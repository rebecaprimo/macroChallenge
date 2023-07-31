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
                ThemeView(themes: themes, viewState: $viewState)
            } else if viewState == .waitingRoom {
                AgentsView()
            } else {
                Text("Erro")
            }
        }
        .onAppear {
            manager.authenticateUser()
        }
      
        //aqui atualiza a view
        .onChange(of: manager.viewState) { newState in
            viewState = newState
        }
    }
}

//var body: some View {
//    ZStack {
//        if matchManager.viewState == .menu {
//            MenuView(matchManager: matchManager, viewState: $matchManager.viewState, themes: themes)
//        } else if matchManager.viewState == .game {
//            GameView().environmentObject(matchManager)
//        } else if matchManager.viewState == .themeSelection {
//            ThemeView(themes: themes, viewState: $matchManager.viewState)
//        } else {
//            Text("Erro")
//        }
//    }
//    .onAppear {
//        matchManager.authenticateUser()
//    }
//}
