//
//  RecordsListViewModel.swift
//  Control It WatchKit Extension
//
//  Created by Leonardo Viana on 03/03/21.
//

import Foundation
import AVFoundation
import Combine

final class RecordsListViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @Published var isAudioPlaying: Bool = false
    @Published var recordings: [Recording] = [Recording]()

    var audioRecorderService: AudioRecorderService
    var audioPlayerService: AudioPlayerService
    
    init(audioRecorderService: AudioRecorderService = .init(),
         audioPlayerService: AudioPlayerService = .init()) {
        self.audioRecorderService = audioRecorderService
        self.audioPlayerService = audioPlayerService
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
    
    func getLocalizedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("dd MMMM yyyy")
        
        return formatter.string(from: date)
    }
}
