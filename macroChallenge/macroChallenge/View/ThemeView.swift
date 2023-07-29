//
//  ThemeView.swift
//  macroChallenge
//
//  Created by Caroline Stelitano on 07/07/23.
//

import SwiftUI

struct ThemeView: View {
    @StateObject var matchManager = Manager()
    @State private var currentTheme: Theme?
    @State private var buttonCount = 0
    @Binding var viewState: ViewState
    
    var themes: [Theme]
    
    init(themes: [Theme], viewState: Binding<ViewState>) {
        self.themes = themes
        _viewState = viewState
    }
    
    var body: some View {
        ZStack {
            Image("fgTema")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
                VStack {
                    HStack {
                        Image("tema")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.15) // Ajuste o tamanho da imagem do tema
                        ZStack {
                            Text(currentTheme?.name ?? "")
                                .foregroundColor(.blue)
                            Button {
                                buttonCount += 1
                                if buttonCount <= 3 {
                                    currentTheme = themes.randomElement()
                                }
                            } label: {
                                Image(systemName: "arrow.clockwise")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geometry.size.width * 0.05, height: geometry.size.height * 0.05) // Ajuste o tamanho da imagem do botão de atualização
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .padding(.top, geometry.size.height * 0.05) // Adicione espaço na parte superior
                    
                    Text("VOCÊ SÓ TEM 3 TENTATIVAS")
                        .foregroundColor(.white)
                        .padding(.top, geometry.size.height * 0.0) // Adicione espaço na parte superior

                    Button {
                        viewState = .game
                    } label: {
                        Image("OK")
                            .resizable()
                            .aspectRatio(contentMode: .fit) // Ajuste a imagem do botão "OK" ao content mode "fit"
                            .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.15) // Ajuste o tamanho do botão "OK"
                    }
                    Spacer()
                }
            }
        }
    }
}
