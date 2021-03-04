//
//  RecordingView.swift
//  Control It WatchKit Extension
//
//  Created by Leonardo Viana on 25/02/21.
//

import SwiftUI

struct RecordingView: View {
    @ObservedObject private var model: RecordingViewModel
    
    init(model: RecordingViewModel = .init()) {
        self.model = model
    }
    
    var body: some View {
        GeometryReader { content in
            ScrollView {
                HStack {
                    Button(action: {
                        withAnimation {
                            model.recordButtonTapped()
                        }
                    }, label: {
                        Image(model.recording ? "Stop Icon" : "Record Icon")
                    })
                    .buttonStyle(PlainButtonStyle())
                }
                .frame(width: content.frame(in: .local).maxX, alignment: .center)
                
                Text("Conte como está se sentindo e o que houve.")
                    .multilineTextAlignment(.center)
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.vertical)
                
                NavigationLink(destination: RecordsListView()) {
                    Text("Gravações")
                        .font(.system(.body, design: .rounded))
                        .bold()
                }
                .padding(.horizontal)
            }
        }
    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecordingView(model: .init())
        }
    }
}
