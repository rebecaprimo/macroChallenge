//
//  ContentView.swift
//  macroChallenge
//
//  Created by rebeca primo on 22/05/23.
//

import SwiftUI

struct MenuView: View {
    //objeto observavel da classe Manager que gerencia o Gamekit
    @ObservedObject var matchManager: Manager
    @Binding var viewState: ViewState
    var themes: [Theme]

    var body: some View {
        
        Color.white.edgesIgnoringSafeArea(.all)
        NavigationView {
            VStack {
                VStack {
                    Spacer()
                    Button {
                        matchManager.startMatchmaking()
                        viewState = .themeSelection
                    } label: {
                        Text("Online")
                            .foregroundColor(.blue)
                            .font(.largeTitle)
                            .bold()
                    }
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
                    ThemeView(themes: themes, viewState: $viewState).environmentObject(matchManager)
                }
            }
            .navigationTitle("Voltar")
            .navigationBarItems(
                trailing:
                    NavigationLink(destination: ConfigView()) {
                        Image(systemName: "gearshape.fill")
                    }
            )
        }
    }
}
