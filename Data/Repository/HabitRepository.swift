//
//  HabitRepository.swift
//  Control It
//
//  Created by Leonardo Viana on 02/03/21.
//

import Foundation

protocol HabitRepository {
    func saveHabit(_ habit : Habit, completionHandler: @escaping (Result<Habit, Error>) -> ())
    func getAllHabit(completionHandler: @escaping (Result<[Habit], Error>) -> ())
    func deleteHabit(_ habit: Habit) -> Error?
}
