//
//  FaleView.swift
//  macroChallenge
//
//  Created by rebeca primo on 13/06/23.
//

import SwiftUI

struct FaleView: View {
    var body: some View {
        ZStack {
            Image("fundoC")
                .resizable()
                .edgesIgnoringSafeArea(.all)
        }
        .navigationBarTitle("Fale conosco", displayMode: .inline)
        .font(.custom("specialagent", size: 20))
    }
}

