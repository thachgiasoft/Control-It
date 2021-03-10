//
//  RecordsListView.swift
//  Control It WatchKit Extension
//
//  Created by Leonardo Viana on 03/03/21.
//

import SwiftUI

struct RecordsListView: View {
    @ObservedObject private var model: RecordsListViewModel
    
    init(model: RecordsListViewModel = .init()) {
        self.model = model
        model.listAllRecordings()
    }
    
    var body: some View {
        ZStack
        {
            if model.shouldShowDeletePanel {
                GeometryReader { content in
                    VStack {
                        HStack {
                            Button(action: {
                                withAnimation {
                                    model.shouldShowDeletePanel = false
                                }
                            }, label: {
                                Text(Translation.Buttons.cancel)
                            })
                            .buttonStyle(PlainButtonStyle())
                            Spacer()
                        }
                        .ignoresSafeArea()
                        Text(Translation.Texts.deletionWarning)
                            .bold()
                            .multilineTextAlignment(.center)
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(.white)
                            .frame(width: content.size.width - 50)
                        Spacer()
                        Button(action: {
                            model.deleteRecording()
                            withAnimation {
                                model.shouldShowDeletePanel = false
                            }
                        }, label: {
                            Text(Translation.Buttons.delete)
                                .bold()
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(.red)
                        })
                        .buttonStyle(PlainButtonStyle())
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: content.frame(in: .local).maxX, height: 40, alignment: .center)
                                .foregroundColor(Color("watchButtonColor"))
                        )
                        .padding(.horizontal)
                    }
                }
            } else {
                VStack {
                    if model.recordings.count > 0 {
                        List {
                            ForEach(Array(model.recordings.enumerated()), id: \.element) { _, record in
                                Button(action: {
                                    model.audioItemTapped(record)
                                }, label: {
                                    Text(Translation.Texts.recording)
                                        .font(.system(.caption, design: .rounded))
                                        .bold()
                                    Text(model.getLocalizedDate(record.createdAt))
                                        .font(.caption2)
                                        .lineLimit(1)
                                })
                            }
                            .onDelete(perform: { indexSet in
                                if let index = indexSet.first {
                                    let item = self.model.recordings[index]
                                    withAnimation {
                                        self.model.showDeletePanelWithRecording(item)
                                    }
                                }
                            })
                        }
                    } else {
                        Text(Translation.Texts.noRecordingsAvailable)
                            .multilineTextAlignment(.center)
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(.gray)
                    }
                }
            }
        }
        .navigationBarTitle(Translation.ViewTitles.recordings)
    }
}

struct RecordsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecordsListView()
        }
    }
}
