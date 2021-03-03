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
    
    var body: some View {
        HStack {
            Image(imageMood)
                .resizable()
                .offset(x: -6)
                .frame(width: 40, height: 40)
                .padding(.leading)
            Spacer()
            Text(name.capitalized)
            Spacer()
        }
    }
}

struct MoodList: View {
    let moodList = Mood.allCases
    var habitRepository: HabitRepository
    
    init(habitRepository: HabitRepository = CDHabitRepository()) {
        self.habitRepository = habitRepository
    }
    
    var body: some View {
        List {
            ForEach(moodList, id: \.rawValue) { mood in
                Button(action: {
                    let habit = Habit(annotation: "", date: Date(), mood: mood)
                    self.habitRepository.saveHabit(habit) { result in
                        switch result {
                        case .success(_):
                            print("\n\nSUCESSO SALVANDO HABITO\n\n")
                        case .failure(let error):
                            print("\n\nERRO SALVANDO HABITO\n\n \(error)")
                        }
                    }
                }, label: {
                    MoodListCell(name: mood.rawValue, imageMood: mood.rawValue)
                        .padding(5)
                })
            }
        }
    }
}

struct MoodList_Previews: PreviewProvider {
    static var previews: some View {
        MoodList()
    }
}
