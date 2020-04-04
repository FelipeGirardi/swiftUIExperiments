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
    
    var audioPlayer: AVPlayer?
    var audioLength: Double = 0.0

    @Published var currentTimeInSeconds: Double = 0.0
    var currentTimeInSecondsPass: AnyPublisher<Double, Never>  {
        return $currentTimeInSeconds
            .eraseToAnyPublisher()
    }
    private var timeObserverToken: Any?
    
    @Published var sliderVolume: Float = 0.5 {
      willSet {
        audioPlayer?.volume = sliderVolume
        print(newValue)
      }
    }
    
    func setAudioPlayer(soundfile: String) {
//        addPeriodicTimeObserver()
        
        if let path = Bundle.main.path(forResource: soundfile, ofType: nil) {
            
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            }
            catch {
                print(error)
            }

//            do {
                let audioURL = URL(fileURLWithPath: path)
                audioLength = getAudioLength(url: audioURL)
                audioPlayer = AVPlayer(url: audioURL)
                //audioPlayer?.prepareToPlay()
//            } catch {
//                print("Error")
//            }
        }
    }
    
    func getAudioLength(url: URL) -> Double {
        let asset = AVURLAsset(url: url, options: nil)
        let audioDuration = asset.duration
        return CMTimeGetSeconds(audioDuration)
    }
    
    func addPeriodicTimeObserver() {
        // Notify every half second
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 1, preferredTimescale: timeScale)

        timeObserverToken = audioPlayer?.addPeriodicTimeObserver(forInterval: time, queue: .main) { [weak self] time in
            // update player transport UI
            self?.currentTimeInSeconds = self?.audioPlayer?.currentTime().seconds ?? 0.0
        }
    }
    
    func removePeriodicTimeObserver() {
        if let timeObserverToken = timeObserverToken {
            audioPlayer?.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
        }
    }
    
    // called when user drags slider to change song time
    func rewindTime(to seconds: Double) {
        let timeCM = CMTime(seconds: seconds, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        audioPlayer?.seek(to: timeCM)
    }

    func playAudio() {
        addPeriodicTimeObserver()
        audioPlayer?.volume = 0.5
        audioPlayer?.play()
    }
    
    func pauseAudio() {
        audioPlayer?.pause()
    }
    
    func setVolume(volume: Float) {
        audioPlayer?.volume = volume
    }
}
