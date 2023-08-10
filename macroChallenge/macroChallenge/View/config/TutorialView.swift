//
//  TutorialView.swift
//  macroChallenge
//
//  Created by rebeca primo on 13/06/23.
//

import Foundation
import SwiftUI

struct TutorialView: View {
    var body: some View {
        ZStack {
            Image("fundoC")
                .resizable()
                .edgesIgnoringSafeArea(.all)
        }
            .navigationTitle("Tutorial")
            .navigationBarTitleDisplayMode(.inline)
    }
}
