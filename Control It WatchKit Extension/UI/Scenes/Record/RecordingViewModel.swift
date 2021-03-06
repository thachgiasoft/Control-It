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
    @Published var shouldShowModalOfMood: Bool = false
    @Published var shouldShowAlertOfError: Bool = false
    private var recordedAudio: AVAudioRecorder?
    var audioRecorderService: AudioRecorder
    var habitRepository: HabitRepository
    var localizedErrorMessage: String?
    
    init(
        audioRecorderService: AudioRecorder = AudioRecorderService(),
        habitRepository: HabitRepository = CDHabitRepository()
    ) {
        self.audioRecorderService = audioRecorderService
        self.habitRepository = habitRepository
    }
    
    func recordButtonTapped(){
        if recording {
            audioRecorderService.stopRecording()
            recording = false
            shouldShowModalOfMood = true
        } else {
            let startRecordingResult = audioRecorderService.startRecording()
            
            switch startRecordingResult {
            case .success(let audio):
                recording = true
                recordedAudio = audio
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func dismissModal(){
        shouldShowModalOfMood = false
    }
    
    func storeNewRecordWithMood(_ mood: Mood){
        if let storeAudio = recordedAudio {
            let newHabit = Habit(audio: storeAudio.url.path, date: Date(), mood: mood)
            habitRepository.saveHabit(newHabit) { result in
                switch result {
                case .success(_):
                    break;
                case .failure(let error):
                    self.localizedErrorMessage = error.localizedDescription
                    self.shouldShowAlertOfError = true
                }
            }
        }
    }
}
