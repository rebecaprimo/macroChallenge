//
//  Themes.swift
//  macroChallenge
//
//  Created by Caroline Stelitano on 07/07/23.
//

import Foundation

struct Theme: Identifiable, Hashable, Codable {
    var id: Int
    var name: String
}

extension Theme {
    static let themes = [Theme(id: 1, name: "Nomes"),
                         Theme(id: 2, name: "Animais"),
                         Theme(id: 3, name: "C.E.P."),
                         Theme(id: 4, name: "Fruta"),
                         Theme(id: 5, name: "Alimento"),
                         Theme(id: 6, name: "Objeto"),
                         Theme(id: 7, name: "Marca"),
                         Theme(id: 8, name: "Profissão"),
                         Theme(id: 9, name: "Música"),
                         Theme(id: 10, name: "Adjetivo"),
                         Theme(id: 11, name: "Cor"),
                         Theme(id: 12, name: "Esporte"),
                         Theme(id: 13, name: "Personagem"),
                         Theme(id: 14, name: "Filme"),
                         Theme(id: 15, name: "Série"),
                         Theme(id: 16, name: "Desenho"),
                         Theme(id: 17, name: "Universo Apple"),
                         Theme(id: 18, name: "Jogos"),
                         Theme(id: 19, name: "Livros"),
                         Theme(id: 20, name: "Motivos para chorar"),
                         Theme(id: 21, name: "Jeitos de chamar o garçom"),
                         Theme(id: 22, name: "Alergia à ..."),
                         Theme(id: 23, name: "Banda"),
                         Theme(id: 24, name: "Perrengue da vida adulta"),
                         Theme(id: 25, name: "Celebridades"),
                         Theme(id: 26, name: "Tem no escritório"),
                         Theme(id: 27, name: "Tem no shopping"),
                         Theme(id: 28, name: "Tem na feira"),
                         Theme(id: 29, name: "Roupas"),
                         Theme(id: 30, name: "Figuras históricas"),
                         Theme(id: 31, name: "Time de futebol"),
                         Theme(id: 32, name: "Super-heróis"),
                         Theme(id: 33, name: "Hobbies"),
                         Theme(id: 34, name: "Tem na cozinha"),
                         Theme(id: 35, name: "Artistas"),
                         Theme(id: 36, name: "Idiomas"),
                         Theme(id: 37, name: "Vilões")]
}
