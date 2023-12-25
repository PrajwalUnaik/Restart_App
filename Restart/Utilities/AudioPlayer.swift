//
//  AudioPlayer.swift
//  Restart
//
//  Created by Prajwal U on 25/12/23.
//

import Foundation
import AVFoundation

var AudioPlayer : AVAudioPlayer?

func playsound(sound: String , type : String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do {
            AudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            AudioPlayer?.play()
        }
        catch{
            print("could not play the sound file.")
        }
    }
}
