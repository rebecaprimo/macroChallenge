//
//  ButtonGame.swift
//  macroChallenge
//
//  Created by rebeca primo on 14/06/23.
//

import SwiftUI
import AVFAudio

struct ButtonGame: View {
    @EnvironmentObject private var matchManager: Manager
    @State var audioPlayer: AVAudioPlayer?
    @State var isPlaying: Bool = true
    @State var isButtonOn = false // Estado individual para cada botão
    @State var letter: String
    private let idButton: Int
    @State private var letterP: String

    init(letter: String, idButton: Int, letterP: String) {
        self.letter = letter
        self.idButton = idButton
        self.letterP = letterP
    }

    func buttonAction(nomeAudio: String){
        self.audioPlayer?.stop()
        audioPlayer = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: nomeAudio, withExtension: "m4a")!)
        self.audioPlayer?.play()
    }

    var body: some View {
        HStack {
            Button(action: {
                buttonAction(nomeAudio: "coin")
                self.isPlaying.toggle()
                matchManager.sendData(buttonId: idButton)
                self.isButtonOn.toggle() // Altere o estado individual do botão
            }, label: {
                Image(matchManager.buttonStates[idButton, default: false] ? letterP : letter)
                    .resizable()
                    .frame(width: 85, height: 85)
            })
            .foregroundColor(.black)
        }
    }
}
