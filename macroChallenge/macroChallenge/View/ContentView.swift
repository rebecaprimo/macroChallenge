//
//  ContentView.swift
//  macroChallenge
//
//  Created by Barbara Argolo on 31/05/23.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @StateObject var matchManager = Manager()
    //   @State var inputAnswer = ""
    
    var body: some View {
        ZStack {
            if matchManager.isGameOver {
                //  GameOverView(matchManager: matchManager)
            } else if matchManager.inGame {
                GameView().environmentObject(matchManager)
            } else {
                MenuView(matchManager: matchManager)
            }
        }
        .onAppear {
            matchManager.authenticateUser()
        }
    }
}
