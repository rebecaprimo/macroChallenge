//
//  Button.swift
//  macroChallenge
//
//  Created by Barbara Argolo on 31/05/23.
//

import SwiftUI
import AVFAudio

//MARK: BOTÃO GERAL

struct ButtonFile: View {
    let screenWidth: CGFloat
    let screenHeight: CGFloat
    let image: String
    let imageWidth: CGFloat
    let imageHeight: CGFloat
    let buttonAction: (() -> Void)
    @Environment(\.screenSize) var screenSize

    
    var body: some View {
        Button (action: {
           buttonAction()
        }, label: {
            Image(image)
                .resizable()
                .frame(width: screenSize.width * imageWidth, height: screenSize.width * imageHeight) // Tamanho proporcional ao tamanho da tela
        })
        .position(x: screenWidth, y: screenHeight)
    }
}
