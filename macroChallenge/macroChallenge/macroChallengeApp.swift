//
//  macroChallengeApp.swift
//  macroChallenge
//
//  Created by rebeca primo on 22/05/23.
//

import Foundation
import SwiftUI


@main
struct YourAppName: App {
    @StateObject private var manager = Manager()
    @State private var showingSplash = true
    @State private var viewState: ViewState = .menu
    var themes: [Theme] = Theme.themes
    

    var body: some Scene {
        WindowGroup {

            // Exibe a ContentView após um atraso de 2 segundos
            ZStack {
                if showingSplash {
                    SplashView()
                } else {
              //      ThemeView(themes: themes, viewState: $viewState).environmentObject(manager) // Injete o Manager aqui

                    ContentView()
                        .environmentObject(manager)
                }
            }
            .onAppear {
                // Simula um atraso de 2 segundos antes de passar para a ContentView
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        showingSplash = false
                    }
                }
            }
        }
    }
}
