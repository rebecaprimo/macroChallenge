//
//  TitleView.swift
//  macroChallenge
//
//  Created by rebeca primo on 07/08/23.
//

import SwiftUI

struct TitleView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left")
                .foregroundColor(.blue) // Personalize a cor do ícone do botão de voltar
                .imageScale(.large)
        }
    }
}
