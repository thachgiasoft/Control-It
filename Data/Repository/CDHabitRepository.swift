//
//  CDHabitRepository.swift
//  Control It
//
//  Created by Ingra Cristina on 24/02/21.
//

import Foundation
import CoreData

class CDHabitRepository : HabitRepository {
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Storage")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        guard let description = container.persistentStoreDescriptions.first else {
            fatalError("###\(#function): Failed to retrieve a persistent store description")
        }
        
        description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        description.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        description.cloudKitContainerOptions?.databaseScope = .public

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    func saveHabit(_ habit: Habit, completionHandler: @escaping (Result<Habit, Error>) -> ()) {
        let context = container.viewContext
        
        let newHabit = NSEntityDescription.insertNewObject(forEntityName: "CDHabit", into: context) as! CDHabit
        
        newHabit.annotation = habit.annotation
        newHabit.audio = habit.audio
        newHabit.date = habit.date
        newHabit.mood = habit.mood.rawValue
        
        do {
            try context.save()
            completionHandler(.success(habit))
        } catch {
            completionHandler(.failure(error))
        }
    }
    
    func getAllHabit(completionHandler: @escaping (Result<[Habit], Error>) -> ()) {
        let context = container.viewContext
        
        let fetchRequest = NSFetchRequest<CDHabit>(entityName: "CDHabit")
        
        do {
            let cdHabits = try context.fetch(fetchRequest)
            let habits = cdHabits.map { (cdHabit) -> Habit in
                let habit : Habit = .init(audio: cdHabit.audio, date: cdHabit.date!, mood: Mood(rawValue: cdHabit.mood!)!, annotation: cdHabit.annotation)
              return habit
                
            }
            DispatchQueue.main.async {
                completionHandler(.success(habits))
            }
        } catch {
            DispatchQueue.main.async {
                completionHandler(.failure(error))
            }
        }
    }
}
