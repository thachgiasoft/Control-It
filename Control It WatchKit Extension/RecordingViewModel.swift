//
//  RecordingViewModel.swift
//  Control It WatchKit Extension
//
//  Created by Leonardo Viana on 25/02/21.
//

import Foundation
import AVFoundation
import Combine

class RecordingViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @Published var recordings: [Recording] = [Recording]()
    @Published var recording: Bool = false
    @Published var isAudioPlaying: Bool = false
    var audioRecorderService: AudioRecorderService
    var audioPlayerService: AudioPlayerService
    
    init(audioRecorderService: AudioRecorderService = .init(),
         audioPlayerService: AudioPlayerService = .init()) {
        self.audioRecorderService = audioRecorderService
        self.audioPlayerService = audioPlayerService
    }
    
    func recordButtonTapped(){
        if recording {
            audioRecorderService.stopRecording(existentRecords: recordings)
            recordings = audioRecorderService.fetchRecordings(lastRecordings: recordings)
            recording = false
        } else {
            let startRecordingResult = audioRecorderService.startRecording()
            
            switch startRecordingResult {
            case .success(_):
                recording = true
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func audioItemTapped(_ item: Recording){
        if !isAudioPlaying {
            let playAudioResult = audioPlayerService.startPlayback(audio: item.fileURL)
            
            switch playAudioResult {
            case .success(let audioPlayer):
                audioPlayer.delegate = self
                self.isAudioPlaying.toggle()
            case .failure(let error):
                print(error)
            }
        } else {
            audioPlayerService.stopPlayback()
            isAudioPlaying = false
        }
    }
    
    func deleteRecording(_ item: Recording){
        if let deleteItemError =
            audioRecorderService.deleteRecordingAtUrl(item.fileURL) {
            print(deleteItemError.localizedDescription)
        } else {
            let findIndex = self.recordings.firstIndex(of: item)
            
            guard let elementId = findIndex else {
                return
            }
            
            let _ = self.recordings.remove(at: elementId)
        }
    }
    
    func listAllRecordings(){
        recordings = audioRecorderService.fetchRecordings(lastRecordings: recordings)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            isAudioPlaying = false
        }
    }
}
