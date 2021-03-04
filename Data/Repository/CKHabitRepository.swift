//
//  CKHabitRepository.swift
//  Control It
//
//  Created by Leonardo Viana on 02/03/21.
//

import Foundation
import CloudKit

class CKHabitRepository: HabitRepository{
    let database: CKDatabase
    
    init() {
        let container: CKContainer = .init(identifier: DataConfig().ckContainer)
        database = container.privateCloudDatabase
    }
    func saveHabit(_ habit: Habit, completionHandler: @escaping (Result<Habit, Error>) -> ()) {
        let habitRecord = CKRecord(recordType: "CD_CDHabit")
        
        habitRecord["CD_annotation"] = habit.annotation
        habitRecord["CD_audio"] = habit.audio
        habitRecord["CD_mood"] = habit.mood.rawValue
        habitRecord["CD_date"] = habit.date
        
        database.save(habitRecord) { (record, error) in
            guard let savedRecord = record, error == nil else {
                completionHandler(.failure(error!))
                return
            }
            
            var newHabit = habit
            newHabit.id = savedRecord.recordID.recordName
            
            completionHandler(.success(habit))
        }
    }
    
    func getAllHabit(completionHandler: @escaping (Result<[Habit], Error>) -> ()) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "CD_CDHabit", predicate: predicate)
        let operation = CKQueryOperation(query: query)
        
        var habits: [Habit] = []
        
        operation.recordFetchedBlock = { record in
            let habit = Habit(id: record.recordID.recordName,
                               audio: record["CD_audio"],
                               date: record["CD_date"] as! Date,
                               mood: Mood(rawValue: record["CD_mood"] as! String) ?? .happy,
                               annotation: record["CD_annotation"])
            
            habits.append(habit)
        }
        
        operation.queryCompletionBlock = { cursor, error in
            if error == nil {
                completionHandler(.success(habits))
            } else {
                completionHandler(.failure(error!))
            }
        }
        database.add(operation)
    }
    
}

