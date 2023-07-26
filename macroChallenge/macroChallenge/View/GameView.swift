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
                    ButtonGame(letter: "A", idButton: 1, isEnabled: matchManager.isCurrentPlayerTurn)
                    ButtonGame(letter: "B", idButton: 2, isEnabled: matchManager.isCurrentPlayerTurn)
                    ButtonGame(letter: "C", idButton: 3, isEnabled: matchManager.isCurrentPlayerTurn)
                }
                HStack {
                    ButtonGame(letter: "D", idButton: 4, isEnabled: matchManager.isCurrentPlayerTurn)
                    ButtonGame(letter: "E", idButton: 5, isEnabled: matchManager.isCurrentPlayerTurn)
                    ButtonGame(letter: "F", idButton: 6, isEnabled: matchManager.isCurrentPlayerTurn)
                }
                HStack {
                    ButtonGame(letter: "G", idButton: 7, isEnabled: matchManager.isCurrentPlayerTurn)
                    ButtonGame(letter: "H", idButton: 8, isEnabled: matchManager.isCurrentPlayerTurn)
                    ButtonGame(letter: "I", idButton: 9, isEnabled: matchManager.isCurrentPlayerTurn)
                }
                HStack {
                    ButtonGame(letter: "J", idButton: 10, isEnabled: matchManager.isCurrentPlayerTurn)
                    ButtonGame(letter: "L", idButton: 11, isEnabled: matchManager.isCurrentPlayerTurn)
                    ButtonGame(letter: "M", idButton: 12, isEnabled: matchManager.isCurrentPlayerTurn)
                }
                HStack {
                    ButtonGame(letter: "N", idButton: 13, isEnabled: matchManager.isCurrentPlayerTurn)
                    ButtonGame(letter: "O", idButton: 14, isEnabled: matchManager.isCurrentPlayerTurn)
                    ButtonGame(letter: "P", idButton: 15, isEnabled: matchManager.isCurrentPlayerTurn)
                }
                HStack {
                    ButtonGame(letter: "Q", idButton: 16, isEnabled: matchManager.isCurrentPlayerTurn)
                    ButtonGame(letter: "R", idButton: 17, isEnabled: matchManager.isCurrentPlayerTurn)
                    ButtonGame(letter: "S", idButton: 18, isEnabled: matchManager.isCurrentPlayerTurn)
                }
                HStack {
                    ButtonGame(letter: "T", idButton: 19, isEnabled: matchManager.isCurrentPlayerTurn)
                    ButtonGame(letter: "U", idButton: 20, isEnabled: matchManager.isCurrentPlayerTurn)
                    ButtonGame(letter: "V", idButton: 21, isEnabled: matchManager.isCurrentPlayerTurn)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
