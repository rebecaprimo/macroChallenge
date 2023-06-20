//
//  Button.swift
//  macroChallenge
//
//  Created by Barbara Argolo on 31/05/23.
//

import SwiftUI
import AVFAudio
struct ButtonFile: View {
    let screenWidth: CGFloat
    let screenHeight: CGFloat
    let image: String
    let imageWidth: CGFloat
    let imageHeight: CGFloat
    let buttonAction: (() -> Void)
    
    var body: some View {
        Button (action: {
           buttonAction()
        }, label: {
            Image(image)
                .resizable()
                .frame(width: imageWidth, height: imageHeight)
        })
        .position(x: screenWidth, y: screenHeight)
    }
}
