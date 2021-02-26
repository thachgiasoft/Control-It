//
//  RecordingView.swift
//  Control It WatchKit Extension
//
//  Created by Leonardo Viana on 25/02/21.
//

import SwiftUI

let arrayTest: [Int] = [1, 2, 3, 4, 5]

struct RecordingView: View {
    @ObservedObject var model: RecordingViewModel
    
    init(model: RecordingViewModel = .init()) {
        self.model = model
    }
    
    var body: some View {
        List {
            Section(
                header:
                    HStack {
                        Spacer()
                        Button(action: {
                            model.recordButtonTapped()
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
                    }.frame(width: .infinity)
            ) {
                ForEach(Array(model.recordings.enumerated()), id: \.element) { _, record in
                    Button(action: {
                        
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
                    print("Delete item")
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