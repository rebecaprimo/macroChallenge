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
    @EnvironmentObject private var matchManager: Manager
    
    var body: some View {
        VStack {
            ZStack {
                Color.clear
                
                CountTimer()
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .position(x: UIScreen.main.bounds.width - 100, y: 50)
            }
            
            VStack(spacing: 10) {
                HStack {
                    ButtonGame(letter: "A", idButton: 1)
                    ButtonGame(letter: "B", idButton: 2)
                    ButtonGame(letter: "C", idButton: 3)
                }
                HStack {
                    ButtonGame(letter: "D", idButton: 4)
                    ButtonGame(letter: "E", idButton: 5)
                    ButtonGame(letter: "F", idButton: 6)
                }
                HStack {
                    ButtonGame(letter: "G", idButton: 7)
                    ButtonGame(letter: "H", idButton: 8)
                    ButtonGame(letter: "I", idButton: 9)
                }
                HStack {
                    ButtonGame(letter: "J", idButton: 10)
                    ButtonGame(letter: "L", idButton: 11)
                    ButtonGame(letter: "M", idButton: 12)
                }
                HStack {
                    ButtonGame(letter: "N", idButton: 13)
                    ButtonGame(letter: "O", idButton: 14)
                    ButtonGame(letter: "P", idButton: 15)
                }
                HStack {
                    ButtonGame(letter: "Q", idButton: 16)
                    ButtonGame(letter: "R", idButton: 17)
                    ButtonGame(letter: "S", idButton: 18)
                }
                HStack {
                    ButtonGame(letter: "T", idButton: 19)
                    ButtonGame(letter: "U", idButton: 20)
                    ButtonGame(letter: "V", idButton: 21)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
