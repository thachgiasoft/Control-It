//
//  AudioRecorderService.swift
//  Control It WatchKit Extension
//
//  Created by Leonardo Viana on 26/02/21.
//

import Foundation
import AVFoundation

extension Date {
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

class AudioRecorderService: ObservableObject {
    var audioRecorder: AVAudioRecorder
    
    init(audioRecorder: AVAudioRecorder = .init()) {
        self.audioRecorder = audioRecorder
    }
    
    func startRecording() -> Result<AVAudioRecorder, Error> {
        let recordingSession = AVAudioSession.sharedInstance()

        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            return.failure(error)
        }

        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

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
            
            return.success(audioRecorder)
        } catch {
            return.failure(error)
        }
    }
    
    func stopRecording(){
        audioRecorder.stop()        
    }
    
    func fetchRecordings(lastRecordings: [Recording]) -> [Recording]{
        var recordings = lastRecordings
        recordings.removeAll()
        
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
        for audio in directoryContents {
            let recording = Recording(fileURL: audio, createdAt: getCreationDate(for: audio))
            recordings.append(recording)
        }
        
        recordings.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedAscending})
        
        return recordings
    }
    
    func deleteRecordingAtUrl(_ url: URL) -> Error? {
        do {
           try FileManager.default.removeItem(at: url)
        } catch {
            return error
        }

        return nil
    }
    
    private func getCreationDate(for file: URL) -> Date {
        if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
            let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
            return creationDate
        } else {
            return Date()
        }
    }
}
