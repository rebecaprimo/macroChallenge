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
    var statusBomba: String
    
    let desafios = ["Dançar chiquititas.", "Imitar um cachorro.", "Carregar alguém no colo em volta da sala.", "Beber 2 copos de água."]
    var textDesafio : String
    
    init(vitoriaGrupo: Bool) {
        self.vitoriaGrupo = vitoriaGrupo
        self.imageVitoriaGrupo = vitoriaGrupo ? "checkmark.square" : "square"
        self.imageVitoriaMestre = vitoriaGrupo ? "square" : "checkmark.square"
        self.nomeVencedor = vitoriaGrupo ? "mestre" : "grupo"
        self.statusBomba = vitoriaGrupo ? "DESARMADA" : "DETONADA"
        self.textDesafio = desafios.randomElement()!
    }
    
}
