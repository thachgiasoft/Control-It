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
        ZStack {
            if model.shouldShowDeletePanel {
                GeometryReader { _ in
                    VStack {
                        HStack {
                            Button(action: {
                                withAnimation {
                                    model.shouldShowDeletePanel = false
                                }
                            }, label: {
                                Text("Cancelar")
                            })
                            .buttonStyle(PlainButtonStyle())
                            Spacer()
                        }
                        Spacer()
                        Text("A gravação será apagada permanentemente.")
                            .bold()
                            .multilineTextAlignment(.center)
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(.white)
                        Spacer()
                        Button(action: {
                            model.deleteRecording()
                            withAnimation {
                                model.shouldShowDeletePanel = false
                            }
                        }, label: {
                            Text("Apagar")
                                .bold()
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(.red)
                        })
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
                                    Text("Gravação")
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
                        Text("Parece que você não tem nenhuma gravação")
                            .multilineTextAlignment(.center)
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}

struct RecordsListView_Previews: PreviewProvider {
    static var previews: some View {
        RecordsListView()
    }
}
