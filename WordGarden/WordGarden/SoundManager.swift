//
//  SoundManager.swift
//  WordGarden
//
//  Created by Kevin Watke on 2/23/22.
//

import UIKit
import AVFoundation

class SoundManager {
    
    static var player: AVAudioPlayer!
    
    static func playSound (name: String) {
        if let sound = NSDataAsset(name: name) {
            
            do {
                try player = AVAudioPlayer(data: sound.data)
                player.play()
            } catch  {
                print("\(error.localizedDescription). Could not initialize AVAudioPlayer object.")
            }
        }
        else {
            print("Could not read data from file.")
        }
    }
    
    
}
