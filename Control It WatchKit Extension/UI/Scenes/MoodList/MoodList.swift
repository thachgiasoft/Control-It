//
//  MoodList.swift
//  Control It WatchKit Extension
//
//  Created by Ingra Cristina on 25/02/21.
//

import SwiftUI

struct MoodListCell: View {
    var name : String
    
    var body: some View {
        HStack {
            Image(name)
                .resizable()
                .offset(x: -6)
                .frame(width: 40, height: 40)
                .padding(.leading)
            Text(Translation.Moods.feeling(name).capitalized)
            Spacer()
        }
    }
}

struct MoodList: View {
    let moodList = Mood.allCases
    @State var isShowingMoodRegisteredPanel: Bool = false
    var habitRepository: HabitRepository
    
    init(habitRepository: HabitRepository = CDHabitRepository()) {
        self.habitRepository = habitRepository
    }
    
    var body: some View {
        ZStack {
            List {
                ForEach(moodList, id: \.rawValue) { mood in
                    Button(action: {
                        let habit = Habit(annotation: "", date: Date(), mood: mood)
                        self.habitRepository.saveHabit(habit) { result in
                            switch result {
                            case .success(_):
                                withAnimation {
                                    self.isShowingMoodRegisteredPanel = true
                                }
                            case .failure(let error):
                                debugPrint(error)
                            }
                        }
                    }, label: {
                        MoodListCell(name: mood.rawValue)
                            .padding(5)
                    })
                }
            }.isHidden(isShowingMoodRegisteredPanel)
            
            if isShowingMoodRegisteredPanel {
                Image("checkRegister")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 110, maxHeight: 115)
                    .onAppear(perform: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                self.isShowingMoodRegisteredPanel = false
                            }
                        }
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
