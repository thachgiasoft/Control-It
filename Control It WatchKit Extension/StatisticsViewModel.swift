//
//  StatisticsViewModel.swift
//  Control It WatchKit Extension
//
//  Created by Gonzalo Ivan Santos Portales on 27/02/21.
//

import Foundation
import SwiftUI // to importando só por conta do CGFloat, vou ver se mudo isso

class StatisticsViewModel : ObservableObject {
    
    @Published var habits : [Habit] = []
    var repository : HabitRepository
    
    init(repository : HabitRepository) {
        self.repository = repository
        loadAllHabits()
    }
    
    func loadAllHabits() {
        switch repository.getAllHabit() {
            case .success(let newHabits):
                self.habits = getCurrentWeek(habits: newHabits)
            case .failure(let error):
                print(error)
        }
    }
    
    private func getCurrentWeek(habits newHabits : [Habit]) -> [Habit] {
        return newHabits.filter { (habit) -> Bool in
            Calendar.current.isDayInCurrentWeek(date: habit.date)!
        }
    }
}

extension StatisticsViewModel {
    var yLabels : [Int] {
        [0,5,10,15,20] // dps posso até fazer um cálculo pra saber esses valores, mas por enquanto vai isso msm
    }
    
    var xLabels : [String] {
        Calendar.current.veryShortWeekdaySymbols
    }
    
    var barHeights : [CGFloat] {
        var barHeights : [CGFloat] = [0,0,0,0,0,0,0]
        if habits.isEmpty {
            return barHeights
        }
        
        let calendar = Calendar.current
        var newHabits = habits
        var currentDate = newHabits.removeFirst().date
        
        let auxIndex = calendar.getWeekDayIndexOf(date: currentDate)
        barHeights[auxIndex] = 1
        
        var count : CGFloat = 1
        
        for habit in habits {
            if calendar.isDate(habit.date, inSameDayAs: currentDate) {
                count += 1
            } else {
                let index = calendar.getWeekDayIndexOf(date: currentDate)
                barHeights[index] = count
                currentDate = habit.date
                count = 1
            }
        }

        return barHeights
    }
}

extension Calendar {
    func isDayInCurrentWeek(date: Date) -> Bool? {
        let currentComponents = Calendar.current.dateComponents([.weekOfYear], from: Date())
        let dateComponents = Calendar.current.dateComponents([.weekOfYear], from: date)

        guard let currentWeekOfYear = currentComponents.weekOfYear, let dateWeekOfYear = dateComponents.weekOfYear else { return nil }
        return currentWeekOfYear == dateWeekOfYear
    }
    
    func getWeekDayIndexOf(date : Date) -> Int {
        Calendar.current.dateComponents([.weekday], from: date).weekday! - 1
    }
}

/*extension Sequence where Iterator.Element == Habit {
    // ...
}*/
