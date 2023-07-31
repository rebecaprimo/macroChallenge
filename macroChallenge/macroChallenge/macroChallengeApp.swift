//
//  macroChallengeApp.swift
//  macroChallenge
//
//  Created by rebeca primo on 22/05/23.
//

import SwiftUI

@main
struct macroChallengeApp: App {
 //   @State private var viewState: ViewState = .menu
     @StateObject var manager = Manager()

    var randomThemes = Theme.themes

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(manager) 
        }
    }
}
