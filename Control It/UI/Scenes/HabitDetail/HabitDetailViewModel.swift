//
//  HabitDetailViewModel.swift
//  Control It
//
//  Created by Gonzalo Ivan Santos Portales on 07/03/21.
//

import Foundation
import SwiftUI

struct HabitDetailViewModelStates {
    var text : String = ""
    var mood : Mood = .angry
}

class HabitDetailViewModel : ObservableObject {
    
    @Published private(set) var habit = Habit(annotation: "", date: Date(), mood: .tired)
    @Published private(set) var states : HabitDetailViewModelStates = .init()
    @Published var showActionSheet: Bool = false
    
    var habitRepository: HabitRepository
    
    var bindings : (
        text : Binding<String>,
        mood : Binding<Mood>
    ) {(
        text : Binding(
            get: {self.states.text},
            set: {self.states.text = $0}
        ),
        mood : Binding(
            get: {self.states.mood},
            set: { self.states.mood = $0}
        )
    )}
    
    init(habit : Habit, habitRepository: HabitRepository = CDHabitRepository()) {
        self.habit = habit
        self.habitRepository = habitRepository
        self.states.text = habit.annotation!
        self.states.mood = habit.mood
    }
    
    func shouldDeleteHabit(){
        let deleteHabitError = habitRepository.deleteHabit(habit)
        if deleteHabitError != nil {
            debugPrint(deleteHabitError!)
        }
    }
    /*func getLocalizedDateInComponents(_ date: Date) -> [String]{
     let formatter = DateFormatter()
     formatter.dateFormat = "dd MMM HH:mm"
     return formatter.string(from: date).localizedUppercase.split{ $0 == " " }.map(String.init)
     }*/
}
