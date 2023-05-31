//
//  MenuView.swift
//  macroChallenge
//
//  Created by Caroline Stelitano on 29/05/23.
//

import SwiftUI

struct MenuView: View {
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: {
                GameView
            }, label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 100, height: 100, alignment: .center)
                        .shadow(radius: 4, x: 0, y: 4)
                        
                    HStack {
                        Text("Próxima")
                            .fontWeight(.bold)
                            .kerning(0.5)
                            .padding(.trailing, 35)
                            .lineLimit(2)
                        Spacer()
                    }
                }
            })
        }
    }
}
