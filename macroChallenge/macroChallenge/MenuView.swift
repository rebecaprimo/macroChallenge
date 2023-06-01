//
//  MenuView.swift
//  macroChallenge
//
//  Created by Caroline Stelitano on 29/05/23.
//

import SwiftUI

struct MenuView: View {
    //objeto observavel da classe Manager que gerencia o Gamekit
    @ObservedObject var matchManager: MatchManager

    
    var body: some View {
        
        Color.black.edgesIgnoringSafeArea(.all)
        
        VStack {
            Spacer()

            Button (
                action: $matchManager.startMatchmaking,
                label: {
                Text("Online")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .bold()
            })
            .disabled(matchManager.authenticationState != .authenticated || matchManager.inGame)
            .padding(.vertical, 20)
            .padding(.horizontal, 100)
            .background(
                //se for authenticado, cai aqui
                Capsule(style: .circular)
                    .fill(matchManager.authenticationState != .authenticated || matchManager.inGame ? .gray : Color(.systemPink))
            )
            
            Text(matchManager.authenticationState.rawValue)
                .font(.headline.weight(.semibold))
                .foregroundColor(.orange)
                .padding()
            
            Spacer()
        }.sheet(isPresented: $matchManager.inGame) {
                   GameView(matchManager: matchManager)
               }
        
    }
}
