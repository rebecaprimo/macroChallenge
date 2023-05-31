//
//  GameView.swift
//  macroChallenge
//
//  Created by Barbara Argolo on 30/05/23.
//

import GameKit
import SwiftUI
import AVFAudio

struct GameView: View {
    
    @ObservedObject var matchManager: Manager
    @State var audioPlayer: AVAudioPlayer?
    @State var isPlaying: Bool = true
    
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
                
            }, label: {
                Image(self.isPlaying == true ? "swift" : "swift2")
                  .resizable()
                  .frame(width: 100, height: 100)
            })
        }
    }
}


//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}
