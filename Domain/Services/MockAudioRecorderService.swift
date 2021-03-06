//
//  MockAudioRecorderService.swift
//  Control It
//
//  Created by Leonardo Viana on 05/03/21.
//

import Foundation
import AVFoundation

final class MockAudioRecorderService: AudioRecorder {
    private var recordings: [Recording] = []
    
    func startRecording() -> Result<AVAudioRecorder, Error> {
        let newRecord: Recording = .init(fileURL: URL(fileURLWithPath: UUID().uuidString), createdAt: .init())
        recordings.append(newRecord)
        
        return .success(.init())
    }
    
    func stopRecording() { }
    
    func fetchRecordings(lastRecordings: [Recording]) -> [Recording] {
        return recordings
    }
    
    func deleteRecordingAtUrl(_ url: URL) -> Error? {
        let deleteRecord = recordings.firstIndex { $0.fileURL == url }
        if let indexOfItemToDelete = deleteRecord {
            recordings.remove(at: indexOfItemToDelete)
        } else {
            let error = NSError(domain: "Can not delete an unexistent record", code: 400)
            return error
        }
        return nil
    }
    
}
