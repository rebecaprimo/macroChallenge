//
//  Themes.swift
//  macroChallenge
//
//  Created by Barbara Argolo on 12/06/23.
//

import Foundation

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
