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
    
//    var nomePerdedor: String
    var statusBomba: String
    var textDesafio : String
    
    init(vitoriaGrupo: Bool, textDesafio: String) {
        self.vitoriaGrupo = vitoriaGrupo
        self.imageVitoriaGrupo = vitoriaGrupo ? "checkmark.square" : "square"
        self.imageVitoriaMestre = vitoriaGrupo ? "square" : "checkmark.square"
//        self.nomePerdedor = vitoriaGrupo ? "mestre" : "grupo"
        self.statusBomba = vitoriaGrupo ? "DESARMADA" : "DETONADA"
        self.textDesafio = vitoriaGrupo ? "Parabéns, você venceu!" : textDesafio
    }
    
}
