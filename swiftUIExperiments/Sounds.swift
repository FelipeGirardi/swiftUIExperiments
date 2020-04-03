//
//  Sounds.swift
//  swiftUIExperiments
//
//  Created by Felipe Girardi on 02/04/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import AVFoundation

class Sounds {

    static var audioPlayer: AVAudioPlayer?
    
    static func setAudioPlayer(soundfile: String) {
        if let path = Bundle.main.path(forResource: soundfile, ofType: nil) {

            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.prepareToPlay()
            } catch {
                print("Error")
            }
        }
    }

    static func playAudio() {
        audioPlayer?.play()
        audioPlayer?.volume = 0.5
    }
    
    static func pauseAudio() {
        audioPlayer?.pause()
    }
    
    static func setVolume(volume: Float) {
        audioPlayer?.volume = volume
    }
}
