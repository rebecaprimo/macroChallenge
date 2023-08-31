//
//  AgentsView.swift
//  macroChallenge
//
//  Created by Barbara Argolo on 30/07/23.
//

import SwiftUI

struct AgentsView: View {
    
    @EnvironmentObject private var manager: Manager

    var body: some View {
        ZStack {
            Image("Agentes")
                .resizable()
                .edgesIgnoringSafeArea(.all)
        }
    }
}
