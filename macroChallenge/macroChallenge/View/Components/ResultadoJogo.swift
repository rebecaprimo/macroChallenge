//
//  Desafios.swift
//  macroChallenge
//
//  Created by Caroline Stelitano on 19/06/23.
//

import Foundation
import UIKit


struct ResultadoJogo {

    var vitoriaGrupo: Bool  //receber true ou false da tela de quantidade de botoes apertados
    var imageVitoriaGrupo: String
    var imageVitoriaMestre: String
    
    var nomeVencedor: String
    
    let desafios = ["Dançar chiquititas.", "Imitar um cachorro.", "Carregar alguém no colo em volta da sala.", "Beber 2 copos de água."]
    var textDesafio : String
    
    init(vitoriaGrupo: Bool) {
        self.vitoriaGrupo = vitoriaGrupo
        self.imageVitoriaGrupo = vitoriaGrupo ? "checkmarkSquare" : "square"
        self.imageVitoriaMestre = vitoriaGrupo ? "square" : "checkmarkSquare"
        self.nomeVencedor = vitoriaGrupo ? "grupo" : "mestre"
        self.textDesafio = desafios.randomElement()!
    }
    
}
