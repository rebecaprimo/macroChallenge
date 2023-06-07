//
//  ResultsView.swift
//  macroChallenge
//
//  Created by Barbara Argolo on 01/06/23.
//

import SwiftUI
//
//struct ResultsView: View {
//    @ObservedObject var matchManager: Manager
//
//    var body: some View {
//        VStack {
//            Text("Results")
//                .font(.largeTitle)
//                .padding()
//            
//            List {
//                ForEach(matchManager.pastGuesses) { guess in
//                    Text(guess.message)
//                        .foregroundColor(.green)
//                }
//            }
//            
//            Button("Play Again") {
//                matchManager.resetGame()
//            }
//            .padding()
//        }
//        .padding()
//        .onReceive(matchManager.$pastGuesses) { _ in
//            // Force view update when pastGuesses changes
//        }
//    }
//}
