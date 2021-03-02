//
//  HabitRepository.swift
//  Control It
//
//  Created by Leonardo Viana on 02/03/21.
//

import Foundation

protocol HabitRepository {
    func saveHabit(_ habit : Habit) -> Result<Habit,Error>
    func getAllHabit() -> Result<[Habit],Error>
}
