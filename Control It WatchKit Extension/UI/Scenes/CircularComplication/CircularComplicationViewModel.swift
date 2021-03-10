//
//  CircularComplicationViewModel.swift
//  Control It WatchKit Extension
//
//  Created by Leonardo Viana on 09/03/21.
//

import Foundation
import SwiftUI

//let fakeHabits: [Habit] = [
//    Habit(annotation: "allala", date: Date(), mood: .angry),
//    Habit(annotation: "allala", date: Date(), mood: .sad),
//    Habit(annotation: "allala", date: Date(), mood: .happy),
//    Habit(annotation: "allala", date: Date(), mood: .bored),
//    Habit(annotation: "allala", date: Date.distantFuture, mood: .angry),
//    Habit(annotation: "allala", date: Date(), mood: .bored),
//    Habit(annotation: "allala", date: Date(), mood: .tired),
//    Habit(annotation: "allala", date: Date(), mood: .angry),
//    Habit(annotation: "allala", date: Date(), mood: .angry),
//]
//
final class CircularComplicationViewModel: ObservableObject {
//    @Published var colors: [Color] = []
    @Published var habits: [Habit] = []

    let habitRepository: HabitRepository
        
    init(habitRepository: HabitRepository = CDHabitRepository()) {
        self.habitRepository = habitRepository
//        loadAllHabits()
    }
    
    func loadAllHabits(){
        habitRepository.getAllHabit { result in
            switch result {
            case .success(let loadedHabits):
                self.habits = loadedHabits
            case .failure(let error):
                print(error)
            }
        }
    }
        
    func getComplicationColorsFrom(habits : [Habit]) -> [Color] {
        var colors: [Color] = []
        
        let habitsOfTheDay = habits.filter { habit in
            Calendar.current.isDateInToday(habit.date)
        }
        
        let orderedHabits = habitsOfTheDay.sorted { (previous, current) -> Bool in
            previous.mood.rawValue > current.mood.rawValue
        }
        
        orderedHabits.forEach { habit in
            colors.append(Color(habit.mood.rawValue))
        }
        
        return colors
    }
}
