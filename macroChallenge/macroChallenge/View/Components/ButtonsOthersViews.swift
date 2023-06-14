//
//  ButtonsOthersViews.swift
//  macroChallenge
//
//  Created by Barbara Argolo on 12/06/23.
//

import SwiftUI

struct ButtonsViews: View {
    var width: CGFloat
    var height: CGFloat
    var image: String?
    
    var body: some View {
        
        Button {
            //ir para a tela do jogo
        } label: {
            RoundedRectangle(cornerRadius: 15).foregroundColor(.blue)
                .frame(width: width, height: height)
                .overlay(
                    Image(systemName: image!)
                        .resizable()
                        .frame(width: 40, height: 40))
                
            }
        }
    }

//struct ButtonsOthersViews_Previews: PreviewProvider {
//    static var previews: some View {
//        ButtonsViews()
//    }
//}
