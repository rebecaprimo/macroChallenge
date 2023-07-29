//
//  ConfigView.swift
//  macroChallenge
//
//  Created by rebeca primo on 12/06/23.
//

import SwiftUI

struct ConfigView: View {
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    RectangleButton(title: "Tutorial", view: AnyView(TutorialView()))
                    RectangleButton(title: "Regras", view: AnyView(RegrasView()))
                    RectangleButton(title: "Som", view: AnyView(SomView()))
                    RectangleButton(title: "Política de privacidade", view: AnyView(PoliticaView()))
                    RectangleButton(title: "Termos de uso", view: AnyView(TermosView()))
                    RectangleButton(title: "Fale conosco", view: AnyView(FaleView()))
                    
                    Spacer()
                }
                .navigationTitle("Configurações")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}


struct ConfigView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigView()
    }
}
