//
//  StatisticsViewModel.swift
//  Control It
//
//  Created by Gonzalo Ivan Santos Portales on 04/03/21.
//

import Foundation
import SwiftUI

class StatisticsViewModel : ObservableObject { // tentei fazer essa view model herdar da outra do watch, mas com o @Published isso não funciona, sad
        
    @Published var habits : [Habit] = []
    @Published var yLabels : [Int] = [0,5,10,15,20] // dps posso até fazer um cálculo pra saber esses valores, mas por enquanto vai isso msm
    @Published var xLabels : [String] = Calendar.current.shortWeekdaySymbols
    @Published var barHeights : [CGFloat] = [0,0,0,0,0,0,0]
    @Published var moodsDict : [Mood : Int] = [.angry:2,.sad:2,.bored:3,.happy:6,.tired:3, .anxious:5]
    
    var repository : HabitRepository

    init(repository : HabitRepository) {
        self.repository = repository
        loadAllHabits()
    }

    func loadAllHabits() {
        repository.getAllHabit { (result) in
            switch result {
            case .success(let newHabits):
                self.habits = self.getCurrentWeek(habits: newHabits)
                self.barHeights = self.computeBarHeights()
                self.moodsDict = self.computeMoodsDict()
            case .failure(let error):
                print(error)
            }
        }
    }

    private func getCurrentWeek(habits newHabits : [Habit]) -> [Habit] {
        newHabits.filter { (habit) -> Bool in
            Calendar.current.isDayInCurrentWeek(date: habit.date)!
        }
    }
    
    private func computeMoodsDict() -> [Mood : Int] {
        let moods = Mood.allCases
        var moodsDict : [Mood : Int] = [:]
        
        for mood in moods {
            moodsDict[mood] = 0
        }
        
        for habit in habits {
            moodsDict[habit.mood]! += 1
        }
        
        return moodsDict
    }

    private func computeBarHeights() -> [CGFloat] {
        var barHeights : [CGFloat] = [0,0,0,0,0,0,0]
        if habits.isEmpty {
            return barHeights
        }
        let calendar = Calendar.current
        var newHabits = habits
        var currentDate = newHabits.removeFirst().date

        var count : CGFloat = 1
        
        for habit in newHabits {
            if calendar.isDate(habit.date, inSameDayAs: currentDate) {
            //if calendar.isDate(habit.date, onTheSameWeekDayOf: currentDate) {
                count += 1
            } else {
                let index = calendar.getWeekDayIndexOf(date: currentDate)
                barHeights[index] += count
                currentDate = habit.date
                count = 1
            }
        }
        
        let index = calendar.getWeekDayIndexOf(date: currentDate)
        barHeights[index] += count
        
        return barHeights
    }
}

extension Calendar { // quero fazer um arquivo swift só com as extensions, pra botar o target dela
    func isDayInCurrentWeek(date: Date) -> Bool? {
        let currentComponents = Calendar.current.dateComponents([.weekOfYear], from: Date())
        let dateComponents = Calendar.current.dateComponents([.weekOfYear], from: date)

        guard let currentWeekOfYear = currentComponents.weekOfYear, let dateWeekOfYear = dateComponents.weekOfYear else { return nil }
        return currentWeekOfYear == dateWeekOfYear
    }
    
    func getWeekDayIndexOf(date : Date) -> Int {
        Calendar.current.dateComponents([.weekday], from: date).weekday! - 1
    }
    
    func isDate(_ date : Date, onTheSameWeekDayOf secondDate : Date) -> Bool {
        let firstComponents = Calendar.current.dateComponents([.weekday], from: date)
        let secondComponents = Calendar.current.dateComponents([.weekday], from: secondDate)

        return firstComponents.weekday == secondComponents.weekday
    }
}
