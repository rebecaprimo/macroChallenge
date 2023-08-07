//
//  RectangleButton.swift
//  macroChallenge
//
//  Created by rebeca primo on 12/06/23.
//

//import SwiftUI
//
//struct RectangleButton: View {
//    private var title: String
//    private let view: AnyView?
//
//    init(title: String, view: AnyView?) {
//        self.title = title
//        self.view = view
//    }
//
//    var body: some View {
//        NavigationLink(destination: view, label: {
//            HStack {
//                Text(title)
//                    .font(.system(size: 20))
//                    .font(.title)
//
//                Spacer()
//
//                Image(systemName: "chevron.right")
//                    .frame(alignment: .trailing)
//            }
//            .frame(height: 20)
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .padding(.vertical, 5)
//            .padding(.horizontal, 25)
//            .foregroundColor(.black)
//        })
//        .padding([.trailing, .leading], 10)
//        .padding(0)
//    }
//}
//
//struct RectangleButton_Previews: PreviewProvider {
//    static var previews: some View {
//        RectangleButton(title: "Teste", view: AnyView(GameView()))
//    }
//}

import SwiftUI

struct RectangleButton<Content: View>: View {
    private var title: String
    private let view: Content?
    
    init(title: String, view: Content?) {
        self.title = title
        self.view = view
    }
    
    var body: some View {
        NavigationLink(destination: view, label: {
            HStack {
                Text(title)
                    .font(.custom("SpecialElite-Regular", size: 20))
                    .font(.title)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .frame(alignment: .trailing)
                    
            }
            .frame(height: 20)
            .padding(.vertical, 5)
            .padding(.horizontal, 25)
            .foregroundColor(.black)
        })
        .padding([.trailing, .leading], 10)
        .padding(0)
        Separator()
    }
}

