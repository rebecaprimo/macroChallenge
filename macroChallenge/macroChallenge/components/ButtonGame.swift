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
    @State var isPlaying = true
    @State var letter: String
    private let idButton: Int

    init(letter: String, idButton: Int) {
        self.letter = letter
        self.idButton = idButton
    }

    func buttonAction(nomeAudio: String){
        self.audioPlayer?.stop()
        audioPlayer = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: nomeAudio, withExtension: "m4a")!)
        self.audioPlayer?.play()
    }

    var body: some View {
        let isPressed = matchManager.buttonStates[idButton, default: false]
        
        HStack {
            Button(action: {
                guard !isPressed else { return }      //to verificando se o botao já foi pressionado. Se não pressionado, prossegue a action
                buttonAction(nomeAudio: "coin")
                self.isPlaying.toggle()
                matchManager.sendData(buttonId: idButton)
                matchManager.verifyAllButtonsArePressed()
            }, label: {
                Image(isPressed ? "swift" : letter)
                    .resizable()
                    .frame(width: 60, height: 60)
                    //.background(matchManager.buttonStates[idButton, default: false] ? Color.red : Color.blue)
            })
            .foregroundColor(.black)
        }
    }
}
