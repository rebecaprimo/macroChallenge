//
//  ThemeView.swift
//  macroChallenge
//
//  Created by Caroline Stelitano on 07/07/23.
//

import SwiftUI

struct ThemeView: View {
    @EnvironmentObject var manager: Manager
    @Binding var viewState: ViewState
    @State private var currentTheme: Theme
    @State private var buttonCount = 0
    var themes: [Theme]
    
    
    var colors = ["Red", "Green", "Blue", "Tartan"]
    @State private var selectedColor = "Red"
    
    
    
    
    init(themes: [Theme], viewState: Binding<ViewState>) {
        self.themes = themes
        _viewState = viewState
        _currentTheme = State(initialValue: themes.first ?? themes[0])
    }
    
    var body: some View {
        ZStack {
            Image("fgTema")
                .resizable()
               // .aspectRatio(contentMode: .fill)
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

                    }.position(x: geometry.size.width / 2, y: geometry.size.height / 1.5)
                    HStack {
                        Button {
                        //    manager.determineGameView()
                            //enviar tema pra tela do jogo
                            //sendData para o tema
//                            manager.sendDataTheme(currentTheme: currentTheme.name)
                            manager.onThemePicked(currentTheme.name)
                            print("valor da variavel: \(currentTheme.name)")
                           // manager.determineGameView(<#String#>)
                            
                            
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
