//
//  ContentView.swift
//  macroChallenge
//
//  Created by rebeca primo on 22/05/23.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @StateObject var matchManager = MatchManager()
    
    var body: some View {
        ZStack {
            if matchManager.inGame {
                GameView(matchManager: matchManager)
            } else {
                MenuView(matchManager: matchManager)
            }
        } .onAppear {
            matchManager.authenticateUser()
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
