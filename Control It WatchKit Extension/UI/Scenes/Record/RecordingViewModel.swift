//
//  RecordingViewModel.swift
//  Control It WatchKit Extension
//
//  Created by Leonardo Viana on 25/02/21.
//

import Foundation
import AVFoundation
import Combine

class RecordingViewModel: ObservableObject {
    @Published var recording: Bool = false
    var audioRecorderService: AudioRecorderService
    
    init(audioRecorderService: AudioRecorderService = .init()) {
        self.audioRecorderService = audioRecorderService
    }
    
    func recordButtonTapped(){
        if recording {
            audioRecorderService.stopRecording()
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
}
