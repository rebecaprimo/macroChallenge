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
                ScrollView(){  //ACERTAR ESSE SCROLL PRA TELAS MENORES E TIRAR NO GRANDE
                    
                    Text("FIM DE JOGO!")
                        .font(.custom("Special Elite", size: 32))
                        .bold()
                        .padding(.top, 200)
//                        .padding(.top, gHeight*0.17)  //no SE esse fica bom
                    
                    HStack(spacing: 0) {
                        Text("Status da bomba")
                            .font(.custom("Special Elite", size: 12))
                            .frame(width: contentWidth/2, alignment: .leading)
                            .fixedSize(horizontal: true, vertical: false)
                            .padding(.leading, 10)
                        
                        Text("\(resultado.statusBomba)")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .bold()
                    }
                    .padding(.top, 60)
                    .frame(width: contentWidth)
                    
                    HStack(spacing: 0) {
                        Text("Vitória")
                            .font(.custom("Special Elite", size: 12))
                            .frame(width: (contentWidth/4)-10, alignment: .leading)
                            .padding(.leading, 10)
                        HStack(spacing: 0){
                            HStack(spacing: 0){
                                Image(systemName: "\(resultado.imageVitoriaGrupo)")
                                Text("Agentes")
                                    .bold()
                                    .padding(.leading, 6)
                            }
                            .padding(.trailing, 14)
                            HStack(spacing: 0){
                                Image(
                                    systemName: "\(resultado.imageVitoriaMestre)")
                                Text("Mestre das Bombas")
                                    .bold()
                                    .padding(.leading, 6)
                            }
                        }
                        .frame(width: (contentWidth/4)*3, alignment: .leading)
                    }
                    .padding(.top, 40)
                    .frame(width: contentWidth)
                    
                    HStack(alignment: .top, spacing: 0) {
                        Text("Desafio")
                            .font(.custom("Special Elite", size: 12))
                            .frame(width: (contentWidth/4)-10, alignment: .leading)
                            .padding(.leading, 10)
                        
                        Text("O \(resultado.nomePerdedor) deve: ")
                        Text("\(resultado.textDesafio)")
                            .bold()
                            .multilineTextAlignment(.center)
                            .frame(width: (contentWidth/4)*3 , height: 70)
                    }
                    .padding(.top, 40)
                    
                    Image(systemName: "folder.fill")
                        .padding(.top, 40)
                    
                    Button(action: {
                            DispatchQueue.main.async {
                                matchManager.viewState = .menu
                            }
                        }, label: {
                            Text("HOME")
                                .foregroundColor(.black)
                                .font(.custom("SF PRO", size: 22)).bold()
                                .frame(width: 200, height: 40)
                                .padding()
//                                .background(.green)    //DIMINUIR ÁREA CLICÁVEL
                        })
                    .frame(height: contentHeight-60)
//                    .background(.red)
                }
            }
            .frame(
                minWidth: gWidth,
                maxWidth: .infinity,
                minHeight: gHeight,
                maxHeight: .infinity
            )
            .background(
                //                .black
                Image("erroJogadores1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            )
            .ignoresSafeArea()
        }
    }
}
