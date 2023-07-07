//
//  ThemeView.swift
//  macroChallenge
//
//  Created by Caroline Stelitano on 07/07/23.
//

import Foundation
import SwiftUI

struct ThemeView: View {
    
    @StateObject var matchManager = Manager()
    @State private var currentTheme: Theme?
    @State private var buttonCount = 0

   // var randomThemes = Theme.themes
    
    var themes: [Theme]

    init( themes: [Theme]) {
        self.themes = themes
    }
//
    var body: some View {
        
            ZStack {

                VStack {
                    GeometryReader { geo in
                    //imagem do anatagonista
                    HStack {
                        Image("checkmarkSquare").resizable()
                            .frame(width: 280, height: 280)
                    }.position(x: geo.size.width / 2, y: geo.size.height / 3.2)
                    //tema e botao refresh
                    
                    HStack {
                        
                        Rectangle()
                            .frame(width: 228, height: 72)
                            .overlay(
                                
                                Text(currentTheme?.name ?? "").foregroundColor(.blue)
                            )
                        Button {
                            //fazer condiçao para randomizar os temas APENAS 3 VEZES
                            buttonCount += 1

                            if buttonCount <= 3 {
                                currentTheme = themes.randomElement()!
                            }
   
                        } label: {
                            
                            Rectangle()
                                .frame(width: 72,height: 72)
                                .foregroundColor(.gray)
                                .overlay(
                                    Image(systemName: "arrow.clockwise")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.black))
                        }
                    }.position(x: geo.size.width / 2, y: geo.size.height / 1.5)
                    
//                    HStack {
//                        //pegar componente do botao e levar para outra tela
//                        ButtonFile(screenWidth: 100, screenHeight: 90, image: "checkmark", imageWidth: 50, imageHeight: 50, buttonAction: <#T##(() -> Void)##(() -> Void)##() -> Void#>)
//                            .foregroundColor(.black)
//                    }.position(x: geo.size.width / 2, y: geo.size.height / 1.2)
                }
            }
            //botao ok
           
        }
    }
}
