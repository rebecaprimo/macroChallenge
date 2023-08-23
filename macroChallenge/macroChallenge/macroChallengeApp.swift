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
            ZStack {
                if showingSplash {
                    SplashView()
                } else {
                    ContentView()
                        .environmentObject(manager)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        showingSplash = false
                    }
                }
            }
        }
    }
}
