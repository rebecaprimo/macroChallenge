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
                Image("fundoC")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    RectangleButton(title: "Tutorial", view: TutorialView())
                    Divider()
                    RectangleButton(title: "Regras", view: RegrasView())
                    Divider()
                    RectangleButton(title: "Som", view: SomView())
                    Divider()
                    RectangleButton(title: "Política de privacidade", view: PoliticaView())
                    Divider()
                    RectangleButton(title: "Termos de uso", view: TermosView())
                    Divider()
                    //RectangleButton(title: "Fale conosco", view: FaleView())
                }
                .navigationTitle("Configurações")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}
