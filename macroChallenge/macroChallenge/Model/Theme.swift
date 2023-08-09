//
//  Themes.swift
//  macroChallenge
//
//  Created by Caroline Stelitano on 07/07/23.
//

import Foundation

//struct Theme {
//    var name: String
//
//
//    static let themes = ["Nomes", "Animais", "C.E.P.", "Fruta", "Alimentos", "Objeto"]
//}


struct Theme: Identifiable, Hashable {
    var id: Int
    var name: String
}

extension Theme {
    static let themes = [Theme(id: 1, name: "Nomes"),
                         Theme(id: 2, name: "Animais"),
                         Theme(id: 3, name: "C.E.P."),
                         Theme(id: 4, name: "Fruta"),
                         Theme(id: 5, name: "Alimentos"),
                         Theme(id: 6, name: "Objeto")]
}
