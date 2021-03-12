//
//  StatisticsViewModel.swift
//  Control It
//
//  Created by Gonzalo Ivan Santos Portales on 04/03/21.
//

import Foundation
import SwiftUI
extension String {
    func removeCharactersContained(in characters : String) -> String {
        let newString = self.filter {!characters.contains($0)}
        return newString
    }
}
class StatisticsViewModel : ObservableObject { // tentei fazer essa view model herdar da outra do watch, mas com o @Published isso não funciona, sad
    @Published var habits : [Habit] = []
    @Published var yLabels : [Int] = [0,5,10,15,20] // dps posso até fazer um cálculo pra saber esses valores, mas por enquanto vai isso msm
    @Published var xLabels : [String] = Calendar.current.shortWeekdaySymbols.map { $0.capitalized.removeCharactersContained(in: ".")
    }
    @Published var barHeights : [Int] = [0,0,0,0,0,0,0]
    @Published var moodsDict : [Mood : Int] = [.angry:0,.sad:0,.normal:0,.happy:0,.tired:0, .anxious:0]
    
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
    
    func getWeekString(of day : Date = .init()) -> String {
        let calendar = Calendar.current
        let dayOfWeek = calendar.component(.weekday, from: day)
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: day)!
        let days = (weekdays.lowerBound ..< weekdays.upperBound)
            .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: day) }  // use `flatMap` in Xcode versions before 9.3
            //.filter { !calendar.isDateInWeekend($0) }
        let firstWeekDay = days.first!.getLocalizedDateInComponents()[0]
        let lastWeekDay = days.last!.getLocalizedDateInComponents()[0]
        let month = day.getLocalizedDateInComponents()[1].capitalized
        
        return "\(firstWeekDay)-\(lastWeekDay) of \(month)"
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

    private func computeBarHeights() -> [Int] {
        var barHeights : [Int] = [0,0,0,0,0,0,0]
        if habits.isEmpty {
            return barHeights
        }
        let calendar = Calendar.current
        var newHabits = habits
        var currentDate = newHabits.removeFirst().date

        var count : Int = 1
        
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

extension Calendar { // quero fazer um arquivo swift só com as extensions, pra botar o target no app todo
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
