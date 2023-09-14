//
//  ConfigView.swift
//  macroChallenge
//
//  Created by rebeca primo on 12/06/23.
//

import SwiftUI

struct ConfigView: View {
    @Binding var viewState: ViewState
    
    var body: some View {
        ZStack {
            Image("fundoC")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Separator()
                RectangleButton(title: "Privacidade", view: PoliticaView())
                RectangleButton(title: "Termos de uso", view: TermosView())
                Spacer()
            }
            .padding(.top, 100)
        }
        .navigationBarTitle("Informações")
        .font(.custom("SpecialElite-Regular", size: 20))
        .navigationBarTitleDisplayMode(.inline)
    }
}


