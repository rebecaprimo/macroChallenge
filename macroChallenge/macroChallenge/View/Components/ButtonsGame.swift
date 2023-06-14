//
//  Button.swift
//  macroChallenge
//
//  Created by Barbara Argolo on 31/05/23.
//

import SwiftUI
import AVFAudio

struct ButtonGame: View {
    //    let screenWidth: CGFloat
    //    let screenHeight: CGFloat
    //    let image: String
    //    let imageWidth: CGFloat
    //    let imageHeight: CGFloat
    //    let buttonAction: (() -> Void)
    @EnvironmentObject private var matchManager: Manager
    @State var audioPlayer: AVAudioPlayer?
    @State var isButtonOn = false
    @State var isPlaying: Bool = true
    // @State var image: String
    
    
   // var lettersAlphabet = Alphabet.lettersAlphabet

    
    func buttonAction(nomeAudio: String){
        self.audioPlayer?.stop()
        audioPlayer = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: nomeAudio, withExtension: "m4a")!)
        self.audioPlayer?.play()
    }
    
    var body: some View {
        
        VStack {
      //      ForEach(lettersAlphabet, id: \.id) { alphabet in
                
                Button(action: {
                    
                    print("botao pressionado")
                    buttonAction(nomeAudio: "coin")
                    self.isPlaying.toggle()
                    matchManager.sendData()
                }) {
         
                    Image(matchManager.buttonState.buttonAction ? "Off" : "On")
                        .resizable()
                        .frame(width: 100, height: 100)
             //           .overlay(
           //                 Text("\(alphabet.letter)"))
                    
                    
                }
            }
        }
    }

