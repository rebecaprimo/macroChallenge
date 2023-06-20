//
//  AnswerViewCard.swift
//  macroChallenge
//
//  Created by Caroline Stelitano on 13/06/23.
//

import SwiftUI

//MARK: Componentes para tela de FIM DA PARTIDA

struct AnswerViewTextCard: View {
    let text: String
    
    
    let textDescription: String
    let frameWidth: CGFloat
    let frameHeight: CGFloat
    let positionWidth: CGFloat
    let positionHeight: CGFloat
    let fontSize: CGFloat
    

    var body: some View {
        
        Text(textDescription)
            .font(.system(size: fontSize))
            .frame(width: frameWidth, height: frameHeight)
            .position(x: positionWidth, y: positionHeight)
            .foregroundColor(.black)
    }
}


struct AnswerViewTextBoldCard: View {
    let textDescription: String
    let frameWidth: CGFloat
    let frameHeight: CGFloat
    let positionWidth: CGFloat
    let positionHeight: CGFloat
    let fontSize: CGFloat
    
    
    var body: some View {
        
        Text(textDescription)
            .bold().font(.system(size: fontSize))
            .frame(width: frameWidth, height: frameHeight)
            .position(x: positionWidth, y: positionHeight)
            .foregroundColor(.black)
    }
}


struct AnswerViewImageCard: View {
    let imageChecks: String
    let frameWidth: CGFloat
    let frameHeight: CGFloat
    let positionWidth: CGFloat
    let positionHeight: CGFloat
    
    var body: some View {
        
        Image(systemName: imageChecks)
            .frame(width: frameWidth, height: frameHeight)
            .position(x: positionWidth, y: positionHeight)
    }
}
