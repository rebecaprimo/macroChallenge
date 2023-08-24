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
    

      var description: String {
          return "Vitória do Grupo: \(vitoriaGrupo), Texto do Desafio: \(textDesafio)"
      }
    
    var nomePerdedor: String
    var statusBomba: String
    var textDesafio : String
    
    init(vitoriaGrupo: Bool, textDesafio: String) {
        self.vitoriaGrupo = vitoriaGrupo
        self.imageVitoriaGrupo = vitoriaGrupo ? "checkmark.square" : "square"
        self.imageVitoriaMestre = vitoriaGrupo ? "square" : "checkmark.square"
        self.nomePerdedor = vitoriaGrupo ? "mestre" : "grupo"
        self.statusBomba = vitoriaGrupo ? "DESARMADA" : "DETONADA"
        self.textDesafio = vitoriaGrupo ? textDesafio : textDesafio
    }
    
    static let desafios = ["Dançar chiquititas.",
                           "Imitar um cachorro.",
                           "Carregar alguém no colo em volta da sala.",
                           "Beber 2 copos de água.",
                           "Imitar um animal usando apenas gestos.",
                           "Responder 3 perguntas engraçadas sem rir.",
                           "Criar uma dança maluca e dançar por 1 minuto.",
                           "Contar uma piada e fazer todos rirem.",
                           "Tocar um objeto vendado e adivinhe o que é.",
                           "Dizer uma frase difícil de forma engraçada.",
                           "Fazer expressões faciais exageradas.",
                           "Imitar um animal de forma convincente.",
                           "Ler um trava-línguas rapidamente sem errar.",
                           "Tentar desenhar um objeto específico vendado.",
                           "Elogiar alguém de forma exagerada e criativa.",
                           "Falar uma frase em um sotaque estrangeiro.",
                           "Contar uma história começando com Eu Nunca...",
                           "Tocar num objeto vendado e adivinhar o que é.",
                           "Imitar um personagem de desenho animado.",
                           "Pegar um objeto com as mãos atrás das costas.",
                           "Imitar uma celebridade na fala ou na ação.",
                           "Gritar em silêncio 3 vezes.",
                           "Contar uma charada.",
                           "Maquiar alguém vendado.",
                           "Dançar ao som de uma música.",
                           "Contar de 10 a 1 começando pelo número 7.",
                           "Provar uma comida vendado e adivinhar o que é."
                           ]
}
