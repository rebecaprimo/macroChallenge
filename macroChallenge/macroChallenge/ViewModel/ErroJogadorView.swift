//
//  ErroJogadorView.swift
//  macroChallenge
//
//  Created by Caroline Stelitano on 12/06/23.
//

import SwiftUI


struct ErroJogadorView: View {
    
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
//                            .background(.gray)
                        
                        Text("\(resultado.statusBomba)")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .bold()
                    }
                    .padding(.top, 60)
                    .frame(width: contentWidth)
//                    .background(.orange)
                    
                    HStack(spacing: 0) {
                        Text("Vitória")
                            .font(.custom("Special Elite", size: 12))
                            .frame(width: (contentWidth/4)-10, alignment: .leading)
                            .padding(.leading, 10)
//                            .background(.purple)
                        HStack(spacing: 0){
                            HStack(spacing: 0){
                                Image(systemName: "\(resultado.imageVitoriaGrupo)")
                                //                                .background(.blue)
                                Text("Agentes")
                                    .bold()
                                    .padding(.leading, 6)
                                //                                .background(.orange)
                            }
                            .padding(.trailing, 14)
                            HStack(spacing: 0){
                                Image(
                                    systemName: "\(resultado.imageVitoriaMestre)")
                                //                                .background(.blue)
                                Text("Mestre das Bombas")
                                    .bold()
                                    .padding(.leading, 6)
                                //                                .background(.orange)
                            }
                        }
                        .frame(width: (contentWidth/4)*3, alignment: .leading)
                    }
                    .padding(.top, 40)
                    .frame(width: contentWidth)
                    //                .background(.cyan)
                    
                    HStack(alignment: .top, spacing: 0) {
                        Text("Desafio")
                            .font(.custom("Special Elite", size: 12))
                            .frame(width: (contentWidth/4)-10, alignment: .leading)
                            .padding(.leading, 10)
//                            .background(.gray)
                        
                        Text("O \(resultado.nomeVencedor) deve:\n\(resultado.textDesafio)")
                            .bold()
                            .multilineTextAlignment(.center)
                            .frame(width: (contentWidth/4)*3 , height: 70)
//                            .background(.green)
                    }
                    .padding(.top, 40)
                    
                    Image(systemName: "folder.fill")
                        .padding(.top, 40)
                    
                    Button(action: {
                            print("tapped!")
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
