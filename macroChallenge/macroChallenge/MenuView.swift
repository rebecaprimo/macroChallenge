//
//  MenuView.swift
//  macroChallenge
//
//  Created by rebeca primo on 29/05/23.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var matchManager: Manager
    
    var body: some View {
        VStack {
            Spacer()
            Button {
                matchManager.startMatchmaking()
            } label: {
                Text("PLAY")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .bold()
            }
            .disabled(matchManager.authenticationState != .authenticated || matchManager.inGame)
            .padding(.vertical, 20)
            .padding(.horizontal, 100)
            .background(
                Capsule(style: .circular)
                    .fill(matchManager.authenticationState != .authenticated || matchManager.inGame ? .gray : Color(.blue))
            )
            
            Text(matchManager.authenticationState.rawValue)
                .font(.headline.weight(.semibold))
                .foregroundColor(.orange)
                .padding()
            
            Spacer()
        }
        .background(
            .green
        )
        .ignoresSafeArea()
        .sheet(isPresented: $matchManager.inGame) {
               GameView()
           }
    }
}

//struct MenuView: View {
//    @ObservedObject var matchManager: MatchManager
//    var body: some View {
//        Button {
//            //todo: call matchMaking menu
//        } label: {
//            Text("Play")
//                .foregroundColor(.white)
//                .font(.largeTitle)
//                .bold()
//        }
//        .disabled(matchManager.authenticationState != .authenticated || matchManager.inGame)
//        .padding(.vertical, 20)
//        .padding(.horizontal, 100)
//        .background(
//            Capsule(style: .circular)
//                .fill(matchManager.authenticationState != .authenticated || matchManager.inGame ? .gray : .black)
//        )
//
//        Spacer()
//
//        //Text(matchManager.authenticationState.rawValue)
//    }
//}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(matchManager: Manager())
    }
}
