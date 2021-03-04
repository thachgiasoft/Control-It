//
//  HabitListViewModel.swift
//  Control It
//
//  Created by Leonardo Viana on 03/03/21.
//

import Foundation
import Combine

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

class HabitListViewModel: ObservableObject {
    @Published var loadedHabits: [Habit] = []
    var habitRepository: HabitRepository
    
    init(habitRepository: HabitRepository = CKHabitRepository()) {
        self.habitRepository = habitRepository
    }
    
    func getAllHabitsInCloud(){
        habitRepository.getAllHabit { result in
            switch result {
            
            case .success(let habits):
                DispatchQueue.main.async {
                    self.loadedHabits = habits.filter { $0.annotation != nil }
                }
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func getLocalizedDateInComponents(_ date: Date) -> [String]{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM HH:mm"
        return formatter.string(from: date).localizedUppercase.split{ $0 == " " }.map(String.init)
    }
}
