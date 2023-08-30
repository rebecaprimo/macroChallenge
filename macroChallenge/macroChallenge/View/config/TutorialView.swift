//
//  TutorialView.swift
//  macroChallenge
//
//  Created by rebeca primo on 13/06/23.
//

import Foundation
import SwiftUI

struct TutorialView: View {
    public let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var selection = 0
    let images = ["splash", "fg", "splash"]
    
    var body: some View {
        VStack {
            TabView(selection: $selection) {
                ForEach(0..<3) { i in
                    Image("\(images[i])")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
        .ignoresSafeArea()
    }
}
