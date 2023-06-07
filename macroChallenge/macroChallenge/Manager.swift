//
//  MatchManager.swift
//  macroChallenge
//
//  Created by rebeca primo on 25/05/23.
//

import Foundation
import GameKit

class Manager: NSObject, ObservableObject {
    @Published var inGame = false
    @Published var isGameOver = false
    @Published var authenticationState = PlayerAuthState.authenticating
    private var hasSentQuestion = false
    @Published var pastGuesses = [PastGuess]()
    @Published var isHost = false
    var match: GKMatch?
    var otherPlayer: GKPlayer?
    var localPlayer = GKLocalPlayer.local
    
    var playerUUIDKey = UUID().uuidString
    
    var rootViewController: UIViewController? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }
    
    @Published var currentQuestion: String?
    
    @Published var playerResponses: [GKPlayer: String] = [:]
    
    func getRandomWord() -> String? {
        return everydayObjects.randomElement()
    }
    
    func authenticateUser() {
        GKLocalPlayer.local.authenticateHandler = { [self] vc, e in
            if let viewController = vc {
                rootViewController?.present(viewController, animated: true)
                return
            }
            
            if let error = e {
                authenticationState = .error
                print(error.localizedDescription)
                
                return
            }
            
            if localPlayer.isAuthenticated {
                if localPlayer.isMultiplayerGamingRestricted {
                    authenticationState = .restricted
                } else {
                    authenticationState = .authenticated
                }
            } else {
                authenticationState = .unauthenticated
            }
        }
    }
    
    func startMatchmaking() {
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 2
        
        let matchmakingVC = GKMatchmakerViewController(matchRequest: request)
        matchmakingVC?.matchmakerDelegate = self
        
        rootViewController?.present(matchmakingVC!, animated: true)
    }
    
    func sendCurrentQuestionToAllPlayers() {
        guard let question = currentQuestion else {
            return
        }
        
        sendString("question:\(question)")
    }
    
    func gameOver() {
        isGameOver = true
        match?.disconnect()
    }
    
    func resetGame() {
        DispatchQueue.main.async { [self] in
            isGameOver = false
            inGame = false
        }
        
        hasSentQuestion = false
        match?.delegate = nil
        match = nil
        otherPlayer = nil
        pastGuesses.removeAll()
        playerUUIDKey = UUID().uuidString
        currentQuestion = nil
        playerResponses.removeAll()
    }
    
    func startGame(newMatch: GKMatch) {
        match = newMatch
        match?.delegate = self
        otherPlayer = match?.players.first
        inGame = true
        
        // Verificar o host com base no identificador único do jogador
        isHost = (localPlayer.teamPlayerID < otherPlayer?.teamPlayerID ?? "")
        
        if isHost {
            // Somente o host gera e envia a pergunta
            generateAndSendQuestion()
        }
    }
    
    func generateAndSendQuestion() {
        guard !hasSentQuestion else {
            print("Warning: Attempted to generate a question, but a question has already been sent.")
            return
        }
        
        guard isHost else {
            print("Warning: Only the host can generate and send a question.")
            return
        }
        
        guard let word = getRandomWord() else {
            print("Error: Failed to generate a word. Is the everydayObjects array empty?")
            return
        }
        
        print("Generated word: \(word)")

        currentQuestion = word
        sendString("word:\(word)")
        hasSentQuestion = true
    }
    
    
    func receivedString(_ message: String) {
        let messageSplit = message.split(separator: ":")
        guard let messagePrefix = messageSplit.first?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        
        let parameter = String(messageSplit.last?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
        
        switch messagePrefix {
        case "began":
            if playerUUIDKey == parameter {
                playerUUIDKey = UUID().uuidString
                sendString("began:\(playerUUIDKey)")
            } else {
                inGame = true
            }
            
        case "word":
            currentQuestion = parameter
            hasSentQuestion = true
        //case "guess":
            //appendPastGuess(guess: parameter)
        default:
            break
        }
    }
    
    
    func appendPastGuess(guess: String) {
        DispatchQueue.main.async { [self] in
            let newGuess = PastGuess(message: guess)
            pastGuesses.append(newGuess)
        }
    }
}

extension Manager: GKMatchDelegate {
    
    func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
        if let message = String(data: data, encoding: .utf8) {
            if message.hasPrefix("strData:") {
                let messageContent = message.replacingOccurrences(of: "strData:", with: "")
                receivedString(messageContent)
            }
        }
    }
    
    func sendString(_ message: String) {
        guard let encoded = "strData:\(message)".data(using: .utf8) else { return }
        sendData(encoded, mode: .reliable)
    }
    
    func sendData(_ data: Data, mode: GKMatch.SendDataMode) {
        do {
            try match?.sendData(toAllPlayers: data, with: mode)
        } catch {
            print(error)
        }
    }
    
    func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState) {
        guard state == .disconnected && !isGameOver else { return }
        let alert = UIAlertController(title: "Player disconnected", message: "The other player disconnected from the game.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.match?.disconnect()
        })
        
        DispatchQueue.main.async {
            self.resetGame()
            self.rootViewController?.present(alert, animated: true)
        }
    }
}

extension Manager: GKMatchmakerViewControllerDelegate {
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFind match: GKMatch) {
        print("Match found, starting game...")
        viewController.dismiss(animated: true)
        startGame(newMatch: match)
    }
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        viewController.dismiss(animated: true)
    }
    
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        viewController.dismiss(animated: true)
    }
}

//class MatchManager: NSObject, ObservableObject {
//    @Published var inGame = false
//    @Published var isGameOver = false
//    @Published var authenticationState = PlayerAuthState.authenticating
//    @Published var isHost = false
//
//    @Published var currentlyAntagonist = false
//
//    @Published var remainingTime = maxTimeRemaining
//
//    var match: GKMatch?
//    var otherPlayer: GKPlayer?
//    var localPlayer = GKLocalPlayer.local
//
//    var playerUUIDKey = UUID().uuidString
//    @Published var playerResponses: [GKPlayer: String] = [:]
//
//    var rootViewController: UIViewController? {
//        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
//        return windowScene?.windows.first?.rootViewController
//    }
//
//    func getRandomWord() -> String? {
//        return everydayObjects.randomElement()
//    }
//
//    func authenticateUser() {
//        GKLocalPlayer.local.authenticateHandler = { [self] vc, e in
//            if let viewController = vc {
//                rootViewController?.present(viewController, animated: true)
//                return
//            }
//
//            if let error = e {
//                authenticationState = .error
//                print(error.localizedDescription)
//
//                return
//            }
//
//            if localPlayer.isAuthenticated {
//                if localPlayer.isMultiplayerGamingRestricted {
//                    authenticationState = .restricted
//                } else {
//                    authenticationState = .authenticated
//                }
//            } else {
//                authenticationState = .unauthenticated
//            }
//        }
//    }
//
//    func startMatchmaking() {
//        let request = GKMatchRequest()
//        request.minPlayers = 2
//        request.maxPlayers = 3
//
//        let matchmakingVC = GKMatchmakerViewController(matchRequest: request)
//        matchmakingVC?.matchmakerDelegate = self
//
//        rootViewController?.present(matchmakingVC!, animated: true)
//    }
//
//    func sendCurrentQuestionToAllPlayers() {
//        guard let question = currentQuestion else {
//            return
//        }
//
//        sendString("question:\(question)")
//    }
//
//    func gameOver() {
//        isGameOver = true
//        match?.disconnect()
//    }
//
//    func resetGame() {
//        DispatchQueue.main.async { [self] in
//            isGameOver = false
//            inGame = false
//        }
//
//        hasSentQuestion = false
//        match?.delegate = nil
//        match = nil
//        otherPlayer = nil
//        pastGuesses.removeAll()
//        playerUUIDKey = UUID().uuidString
//        currentQuestion = nil
//        playerResponses.removeAll()
//    }
//
//    func startGame(newMatch: GKMatch) {
//        match = newMatch
//        match?.delegate = self
//        otherPlayer = match?.players.first
//        inGame = true
//
//        // Verificar o host com base no identificador único do jogador
//        isHost = (localPlayer.teamPlayerID < otherPlayer?.teamPlayerID ?? "")
//
//        if isHost {
//            // Somente o host gera e envia a pergunta
//            generateAndSendQuestion()
//        }
//    }
//
//    func generateAndSendQuestion() {
//        guard !hasSentQuestion else {
//            print("Warning: Attempted to generate a question, but a question has already been sent.")
//            return
//        }
//
//        guard isHost else {
//            print("Warning: Only the host can generate and send a question.")
//            return
//        }
//
//        guard let word = getRandomWord() else {
//            print("Error: Failed to generate a word. Is the everydayObjects array empty?")
//            return
//        }
//
//        print("Generated word: \(word)")
//
//        currentQuestion = word
//        sendString("word:\(word)")
//        hasSentQuestion = true
//    }
//
//
//    func receivedString(_ message: String) {
//        let messageSplit = message.split(separator: ":")
//        guard let messagePrefix = messageSplit.first?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
//
//        let parameter = String(messageSplit.last?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "")
//
//        switch messagePrefix {
//        case "began":
//            if playerUUIDKey == parameter {
//                playerUUIDKey = UUID().uuidString
//                sendString("began:\(playerUUIDKey)")
//            } else {
//                inGame = true
//            }
//
//        case "word":
//            currentQuestion = parameter
//            hasSentQuestion = true
//        case "guess":
//            appendPastGuess(guess: parameter)
//        default:
//            break
//        }
//    }
//
//
//    func appendPastGuess(guess: String) {
//                DispatchQueue.main.async { [self] in
//                    let newGuess = PastGuess(message: guess)
//                    pastGuesses.append(newGuess)
//                }
//            }
//        }
//
//        extension Manager: GKMatchDelegate {
//
//            func match(_ match: GKMatch, didReceive data: Data, fromRemotePlayer player: GKPlayer) {
//                if let message = String(data: data, encoding: .utf8) {
//                    if message.hasPrefix("strData:") {
//                        let messageContent = message.replacingOccurrences(of: "strData:", with: "")
//                        receivedString(messageContent)
//                    }
//                }
//            }
//
//            func sendString(_ message: String) {
//                guard let encoded = "strData:\(message)".data(using: .utf8) else { return }
//                sendData(encoded, mode: .reliable)
//            }
//
//            func sendData(_ data: Data, mode: GKMatch.SendDataMode) {
//                do {
//                    try match?.sendData(toAllPlayers: data, with: mode)
//                } catch {
//                    print(error)
//                }
//            }
//
//            func match(_ match: GKMatch, player: GKPlayer, didChange state: GKPlayerConnectionState) {
//                guard state == .disconnected && !isGameOver else { return }
//                let alert = UIAlertController(title: "Player disconnected", message: "The other player disconnected from the game.", preferredStyle: .alert)
//
//                alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
//                    self.match?.disconnect()
//                })
//
//                DispatchQueue.main.async {
//                    self.resetGame()
//                    self.rootViewController?.present(alert, animated: true)
//                }
//            }
//        }
//
//        extension Manager: GKMatchmakerViewControllerDelegate {
//            func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFind match: GKMatch) {
//                   print("Match found, starting game...")
//                   viewController.dismiss(animated: true)
//                   startGame(newMatch: match)
//               }
//
//            func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
//                viewController.dismiss(animated: true)
//            }
//
//            func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
//                viewController.dismiss(animated: true)
//            }
//        }
