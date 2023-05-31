//
//  MatchManager+GKMAtchDelegate.swift
//  macroChallenge
//
//  Created by Caroline Stelitano on 30/05/23.
//

import Foundation
import GameKit

//extensão do MatchManager adicionando GKMatchDelegate para ter acesso a todas as coisas(fçs) de jogabilidade / diferentes envios de dados
extension MatchManager: GKMatchDelegate {
    
    //processes the data sent from another player to the local player
    //processa os dados enviados de outro jogador para o jogador local
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        
    }
    
    //??? que dados vamos enviar? String? usar id nas letras?
    func sendString(_ message: String) {
        
    }
    
    //???
    func sendData(_ data: Data, mode: GKMatch.SendDataMode) {
        
    }
    
    //Handles when players disconnect or connect from a match
    //Trata quando os jogadores se conectam ou desconectam de uma partida
    func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState) {
        
    }
    
    
}
