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

    var body: some View {
        NavigationView {
            ZStack {
                Image("fundoHome") // Substitua "background" pelo nome da sua imagem de fundo
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()
                    GeometryReader { geometry in
                        Button {
                            matchManager.startMatchmaking()
                         //   viewState = .themeSelection
                        } label: {
                            Image("jogarHome")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geometry.size.width * 0.3) // 30% da largura disponível
                                .opacity(matchManager.authenticationState != .authenticated || matchManager.inGame ? 0.5 : 1.0)
                        }
                        .disabled(matchManager.authenticationState != .authenticated || matchManager.inGame)
                        .padding(.vertical, geometry.size.height * 0.2) // 20% da altura disponível
                        .padding(.horizontal, geometry.size.width * 0.2) // 20% da largura disponível
                    }

                    Text(matchManager.authenticationState.rawValue)
                        .font(.headline.weight(.semibold))
                        .foregroundColor(.white)
                    Spacer()
                }
            }
            .navigationBarItems(
                trailing:
                    NavigationLink(destination: ConfigView()) {
                        Image("confHome")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .scaledToFit()
                            .scaleEffect(1.5)
                    }
            )
        }
    }
}
