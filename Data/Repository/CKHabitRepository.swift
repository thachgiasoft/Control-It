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
        let habitRecord = CKRecord(recordType: "Habit")
        
        habitRecord["annotation"] = habit.annotation
        habitRecord["audio"] = habit.audio
        habitRecord["mood"] = habit.mood.rawValue
        habitRecord["date"] = habit.date
        
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
        let query = CKQuery(recordType: "Habit", predicate: predicate)
        let operation = CKQueryOperation(query: query)
        
        var habits: [Habit] = []
        
        operation.recordFetchedBlock = { record in
            let habit = Habit(id: record.recordID.recordName,
                               audio: record["audio"],
                               date: record["date"] as! Date,
                               mood: Mood(rawValue: record["mood"] as! String) ?? .happy,
                               annotation: record["annotation"])
            
            habits.append(habit)
        }
        
        operation.queryCompletionBlock = { cursor, error in
            if error == nil {
                completionHandler(.success(habits))
            } else {
                completionHandler(.failure(error!))
            }
        }

    }
    
}

