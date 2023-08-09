//
//  ThemeView.swift
//  macroChallenge
//
//  Created by Caroline Stelitano on 07/07/23.
//

import SwiftUI

struct ThemeView: View {
    @EnvironmentObject var manager: Manager
    @State private var currentTheme: Theme?
    @State private var buttonCount = 0
    @Binding var viewState: ViewState
    
    var themes: [Theme]
    var colors = ["Red", "Green", "Blue", "Tartan"]
    @State private var selectedColor = "Red"
    
    init(themes: [Theme], viewState: Binding<ViewState>) {
        self.themes = themes
        _viewState = viewState
        _currentTheme = State(initialValue: themes.first ?? themes[0])
    }
    
    //    var themes: [Theme]
    
    var body: some View {
        ZStack {
            Image("fgTema")
                .resizable()
            //                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
                VStack {
                    HStack {
                        Picker("Choose a theme", selection: $currentTheme) {
                            ForEach(themes) { theme in
                                Text(theme.name).tag(theme)
                            }
                        }.pickerStyle(.wheel)
                        //     Text("You selected: \(currentTheme.name)")
                        //1- PEGAR O TEMA E ARMAZENAR NA CURRENTTHEME,
                        //2- ENVIAR PARA OS JOGADORES O TEMA (sendData)
                        //3- NAVEGAR PARA A TELA DO JOGO
                        //posso fazer os 3 itens numa unica função. Na didReceive é só receber os temas e navegar para a tela do jogo. 
                    }.position(x: geometry.size.width / 2, y: geometry.size.height / 1.5)
                    HStack {
                        Button {
                            manager.determineGameView()
                            //enviar tema pra tela do jogo
                            
                        } label: {
                            Image("OK")
                                .resizable()
                                .aspectRatio(contentMode: .fit) // Ajuste a imagem do botão "OK" ao content mode "fit"
                                .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.15) // Ajuste o tamanho do botão "OK"
                        }
                    }.position(x: geometry.size.width / 2, y: geometry.size.height / 3)
                }
            }
        }
    }
}
