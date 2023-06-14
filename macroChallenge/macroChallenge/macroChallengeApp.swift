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
    var body: some Scene {
        WindowGroup {
            MenuView(matchManager: matchManager)
           ContentView(matchManager: matchManager)
        }
    }
}
