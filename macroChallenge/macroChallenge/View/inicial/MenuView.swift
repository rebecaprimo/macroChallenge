//
//  ContentView.swift
//  macroChallenge
//
//  Created by rebeca primo on 22/05/23.
//

import SwiftUI

struct MenuView: View {
    // objeto observável da classe Manager que gerencia o Gamekit
    @EnvironmentObject var matchManager: Manager
    @Binding var viewState: ViewState
    var themes: [Theme]
    
    @State private var showGameView = false // add o estado para mostrar a Sheet
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("Home-oficial")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        Spacer()
                        NavigationLink(destination: ConfigView(viewState: $viewState)) {
                            Image("confHome")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .scaledToFit()
                                .scaleEffect(1.5)
                                .padding(.leading)
                            }
                        
                        Spacer()
                        
                        NavigationLink(destination: TutorialView()) {
                            Image("tutorial")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .scaledToFit()
                                .scaleEffect(1.5)
                                .padding(.trailing)
                            }
                        }
                        
                        Spacer()
                        
                        Button {
                            matchManager.startMatchmaking()
                        } label: {
                            Image("jogarHome")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150)
                                .opacity(matchManager.authenticationState != .authenticated || matchManager.inGame ? 0.5 : 1.0)
                        }
                        .disabled(matchManager.authenticationState != .authenticated || matchManager.inGame)
                        .padding(.vertical, 80)
                        
                        Text(matchManager.authenticationState.rawValue)
                            .font(.custom("SpecialElite-Regular", size: 15))
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }

