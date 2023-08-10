//
//  TermosView.swift
//  macroChallenge
//
//  Created by rebeca primo on 13/06/23.
//

import SwiftUI

struct TermosView: View {
    var body: some View {
        ZStack {
            Image("fundoC")
                .resizable()
                .edgesIgnoringSafeArea(.all)
        }
            .navigationTitle("Termos de uso")
            .navigationBarTitleDisplayMode(.inline)
    }
}

