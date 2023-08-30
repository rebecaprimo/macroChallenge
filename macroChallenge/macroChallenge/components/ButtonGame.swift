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
    @State private var letterP: String = ""
    @Environment(\.screenSize) var screenSize

    

    init(letter: String, idButton: Int, letterP: String) {
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
        
        GeometryReader { geo in
            HStack {
                Button(action: {
                    DispatchQueue.main.async {
                        if matchManager.isHost {
                            buttonAction(nomeAudio: "coin")
                            self.isPlaying.toggle()
                            matchManager.sendData(buttonId: idButton)
                            matchManager.verifyAllButtonsArePressed()
                        } else {
                            guard !isPressed else { return } // Verifica se o botão já foi pressionado. Se não pressionado, prossegue a action
                            buttonAction(nomeAudio: "coin")
                            self.isPlaying.toggle()
                            matchManager.sendData(buttonId: idButton)
                            matchManager.verifyAllButtonsArePressed()
                        }
                    }
                    
                    self.isButtonOn.toggle() // Altere o estado individual do botão
                }, label: {
                    Image(isPressed ? letter+"P" : letter)
                        .resizable()
                      //  .padding(.horizontal, )
                        .frame(width: geo.size.width * 0.85 , height: geo.size.height * 0.90)
                })
                .foregroundColor(.black)
            }
        }
    }
}
