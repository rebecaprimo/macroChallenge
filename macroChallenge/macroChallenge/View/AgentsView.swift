//
//  AgentsView.swift
//  macroChallenge
//
//  Created by Barbara Argolo on 30/07/23.
//

import SwiftUI

struct AgentsView: View {
    
    @EnvironmentObject private var manager: Manager

    var body: some View {
        ZStack {
            
            VStack {
                GeometryReader { geo in
                    //imagem do anatagonista
                    HStack {
                        Section("Host") {
                          //  Text("o Host é: \($manager.hostIDHistory)")
                        }
                    }
                    HStack {
                        Image("checkmarkSquare").resizable()
                            .frame(width: 280, height: 280)
                    }.position(x: geo.size.width / 2, y: geo.size.height / 3.2)
                    //tema e botao refresh
                    //colocsr o host aqui
                   
                    
                }
            }
        }
    }
}

struct OtherPlayersView_Previews: PreviewProvider {
    static var previews: some View {
        AgentsView()
    }
}
