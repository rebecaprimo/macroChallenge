//
//  ContentView.swift
//  macroChallenge
//
//  Created by rebeca primo on 22/05/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var matchManager = Manager()
    
    var body: some View {
        //GameView()
        ZStack {
            MenuView(matchManager: Manager())
        }
        .onAppear {
            matchManager.authenticateUser()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
