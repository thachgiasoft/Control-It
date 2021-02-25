//
//  RecordingViewModel.swift
//  Control It WatchKit Extension
//
//  Created by Leonardo Viana on 25/02/21.
//

import Combine
import AVFoundation

extension Date {
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

class RecordingViewModel: ObservableObject {
    var audioRecorder: AVAudioRecorder
    @Published var recording = false
    
    init(audioRecorder: AVAudioRecorder = .init()) {
        self.audioRecorder = audioRecorder
    }
    
    func startRecording(){
        let recordingSession = AVAudioSession.sharedInstance()

        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Failed to set up recording session")
        }

        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .systemDomainMask)[0]

        let audioFilename = documentPath.appendingPathComponent("\(Date().toString(dateFormat: "dd-MM-YY_'at'_HH:mm:ss")).m4a")

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.record()
            
            recording = true
        } catch {
            print("Could not start recording")
        }
    }
    
    func stopRecording(){
        audioRecorder.stop()
        recording = false
    }
}
