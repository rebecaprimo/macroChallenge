//
//  SomView.swift
//  macroChallenge
//
//  Created by rebeca primo on 13/06/23.
//

import SwiftUI

struct SomView: View {
    var body: some View {
        ZStack {
            Image("fundoC")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
        }
            .navigationTitle("Som")
            .navigationBarTitleDisplayMode(.inline)
    }
}
