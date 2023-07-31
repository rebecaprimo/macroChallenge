//
//  GameView.swift
//  macroChallenge
//
//  Created by Barbara Argolo on 30/05/23.
//

import GameKit
import SwiftUI
import AVFAudio

struct GameView: View {
        @EnvironmentObject var matchManager: Manager 
        @Binding var viewState: ViewState

    var body: some View {
        ZStack {
            Image("fg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            ZStack {
                Color.clear
                
                CountTimer()
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .position(x: UIScreen.main.bounds.width - 100, y: 50)
            }
            VStack(spacing: 10) {
                Spacer()
                HStack {
                    ButtonGame(letter: "A", idButton: 1, letterP: "AP")
                    ButtonGame(letter: "B", idButton: 2, letterP: "BP")
                    ButtonGame(letter: "C", idButton: 3, letterP: "CP")
                }
                HStack {
                    ButtonGame(letter: "D", idButton: 4, letterP: "DP")
                    ButtonGame(letter: "E", idButton: 5, letterP: "EP")
                    ButtonGame(letter: "F", idButton: 6, letterP: "FP")
                }
                HStack {
                    ButtonGame(letter: "G", idButton: 7, letterP: "GP")
                    ButtonGame(letter: "H", idButton: 8, letterP: "HP")
                    ButtonGame(letter: "I", idButton: 9, letterP: "IP")
                }
                HStack {
                    ButtonGame(letter: "J", idButton: 10, letterP: "JP")
                    ButtonGame(letter: "L", idButton: 11, letterP: "LP")
                    ButtonGame(letter: "M", idButton: 12, letterP: "MP")
                }
                HStack {
                    ButtonGame(letter: "N", idButton: 13, letterP: "NP")
                    ButtonGame(letter: "O", idButton: 14, letterP: "OP")
                    ButtonGame(letter: "P", idButton: 15, letterP: "PP")
                }
                HStack {
                    ButtonGame(letter: "Q", idButton: 16, letterP: "QP")
                    ButtonGame(letter: "R", idButton: 17, letterP: "RP")
                    ButtonGame(letter: "S", idButton: 18, letterP: "SP")
                }
                HStack {
                    ButtonGame(letter: "T", idButton: 19, letterP: "TP")
                    ButtonGame(letter: "U", idButton: 20, letterP: "UP")
                    ButtonGame(letter: "V", idButton: 21, letterP: "VP")
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
