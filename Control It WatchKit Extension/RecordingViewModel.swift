//
//  RecordingViewModel.swift
//  Control It WatchKit Extension
//
//  Created by Leonardo Viana on 25/02/21.
//

import Combine

class RecordingViewModel: ObservableObject {
    @Published var recordings = [Recording]()
    @Published var recording = false
    var audioRecorderService: AudioRecorderService
    
    init(audioRecorderService: AudioRecorderService = .init()) {
        self.audioRecorderService = audioRecorderService
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
    
    func listAllRecordings(){
        recordings = audioRecorderService.fetchRecordings(lastRecordings: recordings)
    }
}
