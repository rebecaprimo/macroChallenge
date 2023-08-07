//
//  TitleView.swift
//  macroChallenge
//
//  Created by rebeca primo on 07/08/23.
//

import SwiftUI

struct TitleView<Content: View>: View {
    private var title: String
    private var view: Content
    
    init(title: String, view: Content) {
        self.title = title
        self.view = view
    }
    
    var body: some View {
        ZStack {
            HStack {
                NavigationLink(destination: view) {
                    Image(systemName: "chevron.left")
                }
                Text(title)
            }
            .font(.custom("SpecialElite-Regular", size: 10))
        }
    }
}
