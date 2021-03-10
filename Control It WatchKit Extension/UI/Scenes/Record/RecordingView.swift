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
            ScrollView(showsIndicators: false) {
                HStack {
                    Button(action: {
                        withAnimation {
                            model.recordButtonTapped()
                        }
                    }, label: {
                        Image(model.recording ? "Stop Icon" : "Record Icon")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: 80)
                    })
                    .buttonStyle(PlainButtonStyle())
                }
                .frame(width: content.frame(in: .local).maxX, alignment: .center)
                
                Text(Translation.Texts.askAboutUserFeeling)
                    .multilineTextAlignment(.center)
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(.white)
                
                NavigationLink(destination: RecordsListView()) {
                    Text(Translation.Links.recordings)
                        .font(.system(.body, design: .rounded))
                        .bold()
                }
                .frame(maxHeight: 50)
                .padding(.horizontal)
            }
            .alert(isPresented: $model.shouldShowAlertOfError) {
                Alert(title: Text(model.localizedErrorMessage ?? ""))
            }
            .sheet(isPresented: $model.shouldShowModalOfMood, content: {
                MoodSheetView(completion: {
                    mood in
                    model.storeNewRecordWithMood(mood)
                    model.dismissModal()
                })
            })
            
        }
        .navigationBarTitle("Curb")
    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecordingView(model: .init())
        }
    }
}
