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
                         Theme(id: 4, name: "Frutas"),
                         Theme(id: 5, name: "Alimentos"),
                         Theme(id: 6, name: "Objetos"),
                         Theme(id: 7, name: "Marcas"),
                         Theme(id: 8, name: "Profissões"),
                         Theme(id: 9, name: "Músicas"),
                         Theme(id: 10, name: "Adjetivos"),
                         Theme(id: 11, name: "Corres"),
                         Theme(id: 12, name: "Esportes"),
                         Theme(id: 13, name: "Personagens"),
                         Theme(id: 14, name: "Filmes"),
                         Theme(id: 15, name: "Séries"),
                         Theme(id: 16, name: "Desenhos"),
                         Theme(id: 17, name: "Universo Apple"),
                         Theme(id: 18, name: "Jogos"),
                         Theme(id: 19, name: "Livros"),
                         Theme(id: 20, name: "Faz rir"),
                         Theme(id: 21, name: "Tem na praia"),
                         Theme(id: 22, name: "Alergia à ..."),
                         Theme(id: 23, name: "Bandas"),
                         Theme(id: 24, name: "Perrengue adulto"),
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
