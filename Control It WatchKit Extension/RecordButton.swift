//
//  RecordButton.swift
//  Control It WatchKit Extension
//
//  Created by Leonardo Viana on 25/02/21.
//

import SwiftUI

struct RecordButton: View {
    @Binding var isRecording: Bool
    var onRecord: () -> Void
    var onStop: () -> Void
    
    var body: some View {
        Button(action: {
            if isRecording {
                onStop()
            } else {
                onRecord()
            }
        }, label: {
            ZStack {
                Circle()
                    .strokeBorder(Color.black,lineWidth: 5)
                    .background(
                        Circle().foregroundColor(isRecording ? .black : .red)
                    )
                if isRecording {
                    Rectangle()
                        .frame(width: 60, height: 60)
                        .cornerRadius(10)
                        .foregroundColor(.red)
                }
            }
        })
        .clipShape(Circle())
    }
}
