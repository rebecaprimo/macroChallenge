//
//  PoliticaView.swift
//  macroChallenge
//
//  Created by rebeca primo on 13/06/23.
//

import SwiftUI

struct PoliticaView: View {
    var body: some View {
        ZStack {
            Image("extensa")
                .resizable()
                .edgesIgnoringSafeArea(.all)
        }
            .navigationTitle("Política de privacidade")
            .navigationBarTitleDisplayMode(.inline)
    }
}

