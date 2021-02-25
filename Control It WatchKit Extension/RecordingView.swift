//
//  RecordingView.swift
//  Control It WatchKit Extension
//
//  Created by Leonardo Viana on 25/02/21.
//

import SwiftUI

struct RecordingView: View {
    @ObservedObject var model: RecordingViewModel
    
    init(model: RecordingViewModel = .init()) {
        self.model = model
    }
    
    var body: some View {
        VStack {
            RecordButton(
                // O state recording está sendo setado dentro das funções do model
                isRecording: $model.recording,
                onRecord: {
                    self.model.startRecording()
                },
                onStop: {
                    self.model.stopRecording()
                })
        }
    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingView(model: .init())
    }
}
