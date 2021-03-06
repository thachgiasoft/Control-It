//
//  MoodSheetView.swift
//  Control It WatchKit Extension
//
//  Created by Leonardo Viana on 05/03/21.
//

import SwiftUI

struct MoodSheetView: View {
    let completion: (Mood) -> ()
    @ObservedObject private var model: MoodSheetViewModel = .init()
    
    let columnsOfItems: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let moods: [Mood] = Mood.allCases
    
    var body: some View {
        VStack {
            Text(Translation.Texts.recordMood)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            LazyVGrid(columns: columnsOfItems, spacing: 20) {
                ForEach(moods, id: \.self) { mood in
                    Button(action: {
                        model.moodWasChosen = true
                        completion(mood)
                    }, label: {
                        Image(mood.rawValue)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 50)
                    })
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }.onDisappear(perform: {
            if !model.moodWasChosen {
                completion(.happy)
            }
        })
    }
}

struct MoodSheetView_Previews: PreviewProvider {
    static var previews: some View {
        MoodSheetView(completion: {
            _ in
        })
    }
}
