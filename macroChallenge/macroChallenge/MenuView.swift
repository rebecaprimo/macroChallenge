//
//  MenuView.swift
//  macroChallenge
//
//  Created by rebeca primo on 29/05/23.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var matchManager: MatchManager
    var body: some View {
        Button {
            //todo: call matchMaking menu
        } label: {
            Text("Play")
                .foregroundColor(.white)
                .font(.largeTitle)
                .bold()
        }
        .disabled(matchManager.autheticationState != .authenticated || matchManager.inGame)
        .padding(.vertical, 20)
        .padding(.horizontal, 100)
        .background(
            Capsule(style: .circular)
                .fill(matchManager.autheticationState != .authenticated || matchManager.inGame ? .gray : .black)
        )
        
        Text(matchManager.autheticationState.rawValue)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(matchManager: MatchManager())
    }
}
