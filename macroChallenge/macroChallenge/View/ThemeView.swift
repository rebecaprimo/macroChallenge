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
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geometry in
                VStack {
                    ZStack {
                        Image("theme")
                            .resizable()
                            .frame(width: 280, height: 200)
                        Picker("Choose a theme", selection: $currentTheme) {
                            ForEach(themes) { theme in
                                Text(theme.name).tag(theme)
                                    .foregroundColor(.black)
                            }
                        }.pickerStyle(.wheel)
                    }.position(x: geometry.size.width / 2, y: geometry.size.height / 1.5)
                    HStack {
                        Button {
                            manager.onThemePicked(currentTheme.name)
                            print("valor da variavel: \(currentTheme.name)")
                        } label: {
                            Image("okButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                //.frame(width: 200, height: 160)
                                .frame(width: 140)
                        }
                    }//.position(x: geometry.size.width / 2, y: geometry.size.height / 3)
                }
            }
        }
    }
}
