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
        model.listAllRecordings()
    }
    
    var body: some View {
        List {
            Section(
                header:
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation {
                                model.recordButtonTapped()
                            }
                        }, label: {
                            Image(model.recording ? "Stop Icon" : "Record Icon")
                        })
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                    },
                footer:
                    HStack {
                        Spacer()
                        Text("Conte como está se sentindo e o que houve.")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                        Spacer()
                    }
            ) {
                ForEach(Array(model.recordings.enumerated()), id: \.element) { _, record in
                    Button(action: {
                        model.audioItemTapped(record)
                    }, label: {
                        Text("Gravação")
                            .font(.caption)
                            .bold()
                        Text(record.fileURL.absoluteString)
                            .font(.caption2)
                            .lineLimit(1)
                    })
                }
                .onDelete(perform: { indexSet in
                    if let index = indexSet.first {
                        let item = self.model.recordings[index]
                        withAnimation {
                            self.model.deleteRecording(item)
                        }
                    }
                })
            }
        }
    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingView(model: .init())
    }
}
