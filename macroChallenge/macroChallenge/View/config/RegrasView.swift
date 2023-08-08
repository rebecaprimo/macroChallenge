//
//  RegrasView.swift
//  macroChallenge
//
//  Created by rebeca primo on 13/06/23.
//

import SwiftUI

struct RegrasView: View {
    var body: some View {
        ZStack {
            Image("extensa")
                .resizable()
                .edgesIgnoringSafeArea(.all)
        }
        .navigationTitle("Regras")
        .navigationBarTitleDisplayMode(.inline)
    }
}
