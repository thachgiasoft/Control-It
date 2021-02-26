//
//  MoodList.swift
//  Control It WatchKit Extension
//
//  Created by Ingra Cristina on 25/02/21.
//

import SwiftUI

struct MoodListCell: View {
    
    var name : String
    var imageMood : String
    //var imageMood: Image
        
    var body: some View {
        HStack {
            Image(imageMood)
             .resizable()
             .offset(x: -6)
             .frame(width: 40, height: 40)
            Spacer()
            Text(name)
            Spacer()
        }
    }
}

struct MoodList: View {
    
    let moodList = Mood.allCases
    
    var body: some View {
        List {
            ForEach(moodList, id: \.rawValue) { mood in
                MoodListCell(name: mood.rawValue, imageMood: mood.rawValue)
            }
        }
        //.clipShape(Circle())
        //.navigationTitle("Mood")
    }
}

struct MoodList_Previews: PreviewProvider {
    static var previews: some View {
        MoodList()
    }
}
