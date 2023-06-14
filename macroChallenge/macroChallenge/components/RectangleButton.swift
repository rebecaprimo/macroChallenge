//
//  RectangleButton.swift
//  macroChallenge
//
//  Created by rebeca primo on 12/06/23.
//

import SwiftUI

struct RectangleButton: View {
    private var title: String
    private let view: AnyView?
    
    init(title: String, view: AnyView?) {
        self.title = title
        self.view = view
    }
    
    var body: some View {
        NavigationLink(destination: view, label: {
            HStack {
                Text(title)
                    .font(.system(size: 20))
                    .font(.title)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .frame(alignment: .trailing)
            }
            .frame(height: 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 20)
            .padding(.horizontal, 25)
            .foregroundColor(.black)
            .background(.gray)
            .cornerRadius(15)
        })
        .padding([.trailing, .leading], 10)
        .padding(0)
    }
}

struct RectangleButton_Previews: PreviewProvider {
    static var previews: some View {
        RectangleButton(title: "Teste", view: AnyView(GameView()))
    }
}
