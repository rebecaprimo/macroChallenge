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
                           "Fazer um objeto, animal ou ação conhecida usando apenas gestos.",
                           "Responder a três perguntas aleatórias de forma engraçada sem rir.",
                           "Criar uma dança maluca e dance por um minuto.",
                           "Contar uma piada ou trocadilho e faça todos rirem.",
                           "Tocar um objeto vendado e adivinhe o que é.",
                           "Dizer uma frase difícil de entender de forma engraçada.",
                           "Fazer uma série de expressões faciais engraçadas ou exageradas.",
                           "Imitar um animal de forma convincente.",
                           "Ler um trava-línguas rapidamente sem tropeçar nas palavras.",
                           "Tentar desenhar um objeto específico enquanto está vendado.",
                           "Elogiar alguém de forma exagerada e criativa por um minuto.",
                           "Falar uma frase em um sotaque estrangeiro aleatório.",
                           "Contar uma história engraçada ou embaraçosa começando com Eu Nunca...",
                           "Tocar um objeto vendado e tente adivinhar o que é com base no tato.",
                           "Escolher um desenho animado e fale como um dos personagens por 1 minuto.",
                           "Realizar uma tarefa simples, como desenhar ou pegar um objeto, com as mãos amarradas atrás das costas.",
                           "Imitar uma celebridade conhecida, seja na fala ou na ação.",
                           "Montar um quebra-cabeça dentro de um limite de tempo.",
                           "Contar uma charada e ver quem consegue adivinhar a resposta.",
                           "Maquiar alguém vendado e depois ver o resultado.",
                           "Dançar ao som de uma música, mas congele quando a música parar, e só continue quando a música voltar tocar.",
                           "Contar de 10 a 1 em ordem decrescente, mas comece com o número 5 e vá inventando números engraçados no meio.",
                           "Colocar um alimento misterioso vendado na boca e tente adivinhar o que é apenas pelo sabor.",
                           "Colar um papel na sua testa com o nome de um personagem famoso e adivinhar quem é fazendo perguntas de sim ou não."]
}
