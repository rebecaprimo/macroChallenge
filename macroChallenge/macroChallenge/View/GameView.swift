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
    
    //MARK: OS USUARIOS TEM QUE VER A MESMA VIEW
    
    @EnvironmentObject private var matchManager: Manager
    @State var audioPlayer: AVAudioPlayer?
    @State var isButtonOn = false
    @State var isPlaying: Bool = true
    
    @State var clickedButtonIDs: Bool = false
    @State var clickedButtonName: [String] = []
    
    
    var inputs : Int = 21
    
    
    var body: some View {
        VStack {
            HStack {
                ButtonGame()
            }
        }
    }
}


//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}
