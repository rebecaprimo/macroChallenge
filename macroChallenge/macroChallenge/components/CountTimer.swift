//
//  Timer.swift
//  macroChallenge
//
//  Created by rebeca primo on 15/06/23.
//

import SwiftUI

struct CountTimer: View {
    @State var timeRemaining = 150 // Tempo em segundos (2 minutos e 30 segundos)
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text(format(timeRemaining))
            .font(.custom("alarm clock", size: 20))
            .onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                }
            }
            .onAppear {
                startTimer()
            }
            .onDisappear {
                stopTimer()
            }
    }
    
    func startTimer() {
        timeRemaining = 150 // Tempo inicial em segundos (2 minutos e 30 segundos)
    }
    
    func stopTimer() {
        timer.upstream.connect().cancel()
    }
    
    func format(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}
