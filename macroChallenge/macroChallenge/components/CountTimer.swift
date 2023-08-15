//
//  Timer.swift
//  macroChallenge
//
//  Created by rebeca primo on 15/06/23.
//

import SwiftUI


struct CountTimer: View {
    @EnvironmentObject private var matchManager: Manager
    @State var timeRemaining = 90 // Tempo em segundos (2 minutos e 30 segundos)
    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    var timeIsUp: () -> Void
    
    var body: some View {
        ZStack {
            Image("tempo")
                .resizable()
                .frame(width: 110, height: 52)
            
            
            Text(format(timeRemaining))
                .font(.custom("alarm clock", size: 30))
                .foregroundColor(.black)
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topTrailing)
        .onAppear {
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    func startTimer() {
        DispatchQueue.global().async {
            while timeRemaining > 0 {
                Thread.sleep(forTimeInterval: 1)
                DispatchQueue.main.async {
                    timeRemaining -= 1
                }
            }
            timeIsUp()
        }
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


