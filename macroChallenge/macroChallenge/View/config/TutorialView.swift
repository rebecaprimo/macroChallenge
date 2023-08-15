//
//  TutorialView.swift
//  macroChallenge
//
//  Created by rebeca primo on 13/06/23.
//

import Foundation
import SwiftUI

struct TutorialView: View {
    var body: some View {
        ZStack {
            Image("jogar")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                Text("""
                     -> Bem-vindos, corajosos agentes! Vocês foram convocados para uma missão perigosa que exigirá seu intelecto afiado e nervos de aço. Em um cenário de suspense e urgência, vocês se tornarão uma equipe de especialistas em desarmar bombas.

                     -> Objetivo do jogo:
                     Os jogadores devem rapidamente falar palavras que comecem com uma letra específica, referentes ao tema escolhido pelo Mestre das Bombas,  dentro de um período de tempo determinado para desarmar a bomba.

                     -> Preparação:
                     Reúnam-se em um local confortável e tranquilo, conectados a mesma rede de internet.
                     Pressione jogar e conecte-se com seus amigos.


                     -> Dinâmica do jogo:
                     Com todos no lobby, o jogo irá começar e o Mestre das Bombas será escolhido aleatoriamente.
                     O Mestre das Bombas poderá escolher livremente um dos temas.
                     O jogo começa com um timer de 2 (dois) minutos.
                     Os agentes devem avançar, mencionando palavras diferentes e pressionando as letras iniciais correspondentes, sem repetições.
                     O Mestre das Bombas deve acompanhar atentamente as palavras mencionadas pelos jogadores para garantir que estejam corretas e relacionadas ao tema.
                     O Mestre das Bombas também terá o poder de desapertar uma letra em caso de engano ou tentativa de trapaça, dando ele um bônus de eliminar uma letra correta como punição pelo erro dos agentes.
                     Na próxima rodada, o Mestre das Bombas será sorteado novamente entre o grupo.

                     -> Vencendo o jogo:
                     A vitória dos agentes é determinada quando a bomba é desarmada, dando ao Mestre das Bombas um desafio a ser pago.
                     Caso os agentes não terminem o jogo à tempo e a bomba explodir, a vitória será do Mestre das Bombas e, assim como antes, o grupo todo dos agentes devem pagar a prenda.

                     -> Preparem-se para uma corrida contra o tempo, onde o suspense e a adrenalina são constantes.
                      Serão vocês capazes de enfrentar e superar o Mestre das Bombas e desarmar a bomba antes que o relógio chegue ao fim?
                     A missão aguarda vocês, agentes destemidos. A hora de agir é agora!
                     Divirtam-se e boa sorte!
                     """)
                .multilineTextAlignment(.leading)
                .padding(.leading, 30)
                .padding(.trailing, 30)
                .padding(.top, 100)
                .foregroundColor(.black)
            }
        }
            .navigationTitle("Tutorial")
            .navigationBarTitleDisplayMode(.inline)
    }
}
