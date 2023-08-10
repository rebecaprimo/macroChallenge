//
//  Timer.swift
//  macroChallenge
//
//  Created by rebeca primo on 15/06/23.
//

import SwiftUI


struct CountTimer: View {
    @State var timeRemaining = 20 // Tempo em segundos (2 minutos e 30 segundos)
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var timeIsUp: () -> Void
    
    var body: some View {
        ZStack {
            Image("tempo")
                .resizable()
                .frame(width: 110, height: 52)
            
            
            Text(format(timeRemaining))
                .font(.custom("alarm clock", size: 30))
                .onReceive(timer) { _ in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    } else {
                        timeIsUp()
                    }
                }
                .onAppear {
                    startTimer()
                }
                .onDisappear {
                    stopTimer()
                }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topTrailing)
    }
    func startTimer() {
        timeRemaining = 20 // Tempo inicial em segundos (2 minutos e 30 segundos)

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
