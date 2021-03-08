//
//  RegisterHabitViewModel.swift
//  Control It
//
//  Created by Gonzalo Ivan Santos Portales on 07/03/21.
//

import Foundation
import SwiftUI

class RegisterHabitViewModel : ObservableObject {
    @Published var habit = Habit(annotation: Translation.Placeholders.typeHere, date: Date(), mood: .angry)
    var repository : HabitRepository
    
    init(repository : HabitRepository) {
        self.repository = repository
    }
    
    var bindings : (
        text : Binding<String>,
        mood : Binding<Mood>
    ) {(
        text : Binding(
            get: {self.habit.annotation!},
            set: {self.habit.annotation = $0}
        ),
            mood : Binding(
                get: {self.habit.mood},
                set: { self.habit.mood = $0}
        )
    )}
    
    func saveHabit(_ newHabit : Habit) {
        repository.saveHabit(newHabit) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let habit):
                print(habit)
            }
        }
    }
}
