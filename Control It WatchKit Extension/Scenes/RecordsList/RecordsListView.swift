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
                        self.model.deleteRecording(item)
                    }
                }
            })
        }
    }
    
}

struct RecordsListView_Previews: PreviewProvider {
    static var previews: some View {
        RecordsListView()
    }
}
