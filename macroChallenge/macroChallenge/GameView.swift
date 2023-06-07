//
//  GameView.swift
//  macroChallenge
//
//  Created by rebeca primo on 30/05/23.
//

import SwiftUI

struct GameView: View {
    @State var background = Color.black
    
    var body: some View {
        HStack {
            Button {
                print("tappled button")
                self.background = Color.blue
            } label: {
                Text("PRESS ME")
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    .background(background)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
