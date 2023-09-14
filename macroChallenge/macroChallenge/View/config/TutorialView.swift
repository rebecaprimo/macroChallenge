//
//  TutorialView.swift
//  macroChallenge
//
//  Created by rebeca primo on 13/06/23.
//

import Foundation
import SwiftUI

struct TutorialView: View {
    @State private var selection = 0
    let images = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    var body: some View {
        ZStack {
            Color.black
            VStack {
                TabView(selection: $selection) {
                    ForEach(0..<9) { i in
                        Image("\(images[i])")
                            .resizable()
                            .ignoresSafeArea(.all)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .never))
            }
        }.ignoresSafeArea()
    }
}
