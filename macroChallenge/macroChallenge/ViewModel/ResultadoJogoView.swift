//
//  ErroJogadorView.swift
//  macroChallenge
//
//  Created by Caroline Stelitano on 12/06/23.
//

import SwiftUI

struct ResultadoJogoView: View {

    @EnvironmentObject var matchManager: Manager
    @State var resultado : ResultadoJogo

    var body: some View {
        GeometryReader { g in
            let gWidth = g.size.width
            let gHeight = g.size.height

            let contentPadding = 38.0
            var contentWidth = gWidth - (contentPadding*2)
            var contentHeight = gHeight - 200 - 200

            VStack(alignment: HorizontalAlignment.center, spacing: 0) {
                Text("Fim de jogo!")
                    .font(.custom("Special Elite", size: 40))
                    .padding(.top, 57)

                HStack(spacing: 0) {
                    Text("Status da bomba")
                        .font(.custom("Special Elite", size: 15))
                        .frame(width: contentWidth/2, alignment: .leading)
                        .fixedSize(horizontal: true, vertical: false)
                        .padding(.leading, 10)

                    Text("\(resultado.statusBomba)")
                        .font(.custom("Special Elite", size: 25))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .bold()
                }
                .padding(.top, 60)
                .frame(width: contentWidth)

                HStack(spacing: 0) {
                    Text("Vitória")
                        .font(.custom("Special Elite", size: 15))
                        .frame(width: (contentWidth/4)-10, alignment: .leading)
                        .padding(.leading, 10)
                    HStack(spacing: 0){
                        HStack(spacing: 0){
                            Image(systemName: "\(resultado.imageVitoriaGrupo)")
                            Text("Agentes")
                                .font(.custom("Special Elite", size: 15))
                                .padding(.leading, 6)
                        }
                        .padding(.trailing, 10)
                        HStack(spacing: 0){
                            Image(systemName: "\(resultado.imageVitoriaMestre)")
                            Text("Mestre das Bombas")
                                .multilineTextAlignment(.center)
                                .font(.custom("Special Elite", size: 15))
                                .padding(.leading, 6)
                        }
                    }
                    .frame(width: (contentWidth/4)*3, alignment: .leading)
                }
                .padding(.top, 40)
                .frame(width: contentWidth)

                HStack(spacing: 0) {
                    Text("Desafio")
                        .font(.custom("Special Elite", size: 15))
                        .frame(width: (contentWidth/4)-10, alignment: .leading)
                        .padding(.leading, 10)

                    Text("O \(resultado.nomePerdedor) deve: \n\(resultado.textDesafio)")
                        .multilineTextAlignment(.center)
                        .font(.custom("Special Elite", size: 15))
                        .frame(width: (contentWidth/4)*3 , height: 70)
                }
                .padding(.top, 20)

                Button(action: {
                    DispatchQueue.main.async {
                        matchManager.viewState = .menu
                        matchManager.resetGame()
                    }
                }, label: {
                    Image("home")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150)
                })
                .position(x: gWidth / 2, y: gHeight / 2)
                .frame(height: contentHeight-60)
            }
            .frame(
                minWidth: gWidth,
                maxWidth: .infinity,
                minHeight: gHeight,
                maxHeight: .infinity
            )
            .background(
                Image("feedback")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
            )
        }
    }
}
