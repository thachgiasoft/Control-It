//
//  AudioPlayerService.swift
//  Control It WatchKit Extension
//
//  Created by Leonardo Viana on 26/02/21.
//

import AVFoundation

class AudioPlayerService: NSObject, ObservableObject {
    var audioPlayer: AVAudioPlayer
    
    init(audioPlayer: AVAudioPlayer = .init()) {
        self.audioPlayer = audioPlayer
    }
    
    func startPlayback(audio: URL) -> Result<AVAudioPlayer, Error>{
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audio)
            audioPlayer.play()
            
            return .success(audioPlayer)
        } catch {
            return .failure(error)
        }
    }
    
    func stopPlayback(){
        audioPlayer.stop()
    }
}
