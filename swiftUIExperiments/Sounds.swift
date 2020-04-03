//
//  Sounds.swift
//  swiftUIExperiments
//
//  Created by Felipe Girardi on 02/04/20.
//  Copyright © 2020 Felipe Girardi. All rights reserved.
//

import AVFoundation
import Combine

class Sounds: ObservableObject {
    
    var audioPlayer: AVAudioPlayer?

    @Published var sliderVolume: Float = 0.5 {
      willSet {
        audioPlayer?.volume = sliderVolume
        print(newValue)
      }
    }
    
    func setAudioPlayer(soundfile: String) {
        if let path = Bundle.main.path(forResource: soundfile, ofType: nil) {

            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.prepareToPlay()
            } catch {
                print("Error")
            }
        }
    }

    func playAudio() {
        audioPlayer?.play()
        audioPlayer?.volume = 0.5
    }
    
    func pauseAudio() {
        audioPlayer?.pause()
    }
    
    func setVolume(volume: Float) {
        audioPlayer?.volume = volume
    }
}
