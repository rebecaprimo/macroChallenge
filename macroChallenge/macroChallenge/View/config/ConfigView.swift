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
                //TitleView(title: "Configurações", view: MenuView(viewState: $viewState, themes: themes))
                Separator()
                RectangleButton(title: "Tutorial", view: TutorialView())
                RectangleButton(title: "Regras", view: RegrasView())
                RectangleButton(title: "Privacidade", view: PoliticaView())
                RectangleButton(title: "Termos de uso", view: TermosView())
                RectangleButton(title: "Fale conosco", view: FaleView())
            }
            .padding(.top, 30) // Adicionando o padding na VStack para posicioná-la na parte superior
        }
        .navigationBarTitle("Menu")
        .font(.custom("SpecialElite-Regular", size: 20))
        .navigationBarTitleDisplayMode(.inline)
    }
}


