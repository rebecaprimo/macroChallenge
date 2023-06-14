//
//  InicialView.swift
//  macroChallenge
//
//  Created by rebeca primo on 14/06/23.
//

import SwiftUI

struct InicialView: View {

    var body: some View {
        NavigationView {
            VStack {
                RectangleButton(title: "iniciar", view: AnyView(GameView()))
            }
            .navigationBarItems(
                trailing:
                    NavigationLink(destination: ConfigView()) {
                        Image(systemName: "gearshape.fill")
                    }
            )
        }
    }
}

struct InicialView_Previews: PreviewProvider {
    static var previews: some View {
        InicialView()
    }
}
