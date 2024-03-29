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
        @Environment(\.screenSize) var screenSize
        @Binding var viewState: ViewState

    var body: some View {
        ZStack {
            Image("gameFundo")
                .resizable()
               // .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea(.all)
            GeometryReader { geometry in
                VStack(spacing: 20) {
                    HStack() {
                        Text(matchManager.currentTheme?.name ?? "")
                            .font(.custom("SpecialElite-Regular", size: 20))
                            .frame(
                                maxWidth: .infinity,
                                maxHeight: .infinity,
                                alignment: .topLeading)
                            .padding(.vertical, 5)
                            .foregroundColor(.black)
             
                        CountTimer(timeIsUp: matchManager.endTimer)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 30)
                }
                
                VStack() {
                        Spacer()
                        HStack(spacing: 10) {
                            ButtonGame(letter: "A", idButton: 1, letterP: "AP")
                            ButtonGame(letter: "B", idButton: 2, letterP: "BP")
                            ButtonGame(letter: "C", idButton: 3, letterP: "CP")
                        }.frame(height: geometry.size.height * 0.12)
                        .padding(.horizontal, 40)

                        HStack(spacing: 10) {
                            ButtonGame(letter: "D", idButton: 4, letterP: "DP")
                            ButtonGame(letter: "E", idButton: 5, letterP: "EP")
                            ButtonGame(letter: "F", idButton: 6, letterP: "FP")
                        }.frame(height: geometry.size.height * 0.12)
                        .padding(.horizontal, 40)

                        
                        HStack(spacing: 10) {
                            ButtonGame(letter: "G", idButton: 7, letterP: "GP")
                            ButtonGame(letter: "H", idButton: 8, letterP: "HP")
                            ButtonGame(letter: "I", idButton: 9, letterP: "IP")
                        }.frame(height: geometry.size.height * 0.12)
                        .padding(.horizontal, 40)

   
                        HStack(spacing: 10) {
                            ButtonGame(letter: "J", idButton: 10, letterP: "JP")
                            ButtonGame(letter: "L", idButton: 11, letterP: "LP")
                            ButtonGame(letter: "M", idButton: 12, letterP: "MP")
                        }.frame(height: geometry.size.height * 0.12)
                        .padding(.horizontal, 40)


                        HStack(spacing: 10) {
                            ButtonGame(letter: "N", idButton: 13, letterP: "NP")
                            ButtonGame(letter: "O", idButton: 14, letterP: "OP")
                            ButtonGame(letter: "P", idButton: 15, letterP: "PP")
                        }.frame(height: geometry.size.height * 0.12)
                        .padding(.horizontal, 40)

                        
                        HStack(spacing: 10) {
                            ButtonGame(letter: "Q", idButton: 16, letterP: "QP")
                            ButtonGame(letter: "R", idButton: 17, letterP: "RP")
                            ButtonGame(letter: "S", idButton: 18, letterP: "SP")
                        }.frame(height: geometry.size.height * 0.12)
                        .padding(.horizontal, 40)

                        
                        HStack(spacing: 10) {
                            ButtonGame(letter: "T", idButton: 19, letterP: "TP")
                            ButtonGame(letter: "U", idButton: 20, letterP: "UP")
                            ButtonGame(letter: "V", idButton: 21, letterP: "VP")
                        }.frame(height: geometry.size.height * 0.12)
                        .padding(.horizontal, 40)


                }.frame(width: geometry.size.width , height: geometry.size.height * 0.60)
                    .padding(.vertical, 200)
                   // .padding(.leading, 50)
                    .padding(.horizontal, 10)
                    
                
            }.padding(.bottom, 60)

        }
    }
}
