//
//  macroChallengeApp.swift
//  macroChallenge
//
//  Created by rebeca primo on 22/05/23.
//

import SwiftUI

@main
struct macroChallengeApp: App {
    @StateObject var manager = Manager()
    var randomThemes = Theme.themes
    
    var body: some Scene {
        WindowGroup {
       //     ContentView(matchManager: matchManager, viewState: $matchManager.viewState)
         ContentView().environmentObject(manager)
        }
    }
}
