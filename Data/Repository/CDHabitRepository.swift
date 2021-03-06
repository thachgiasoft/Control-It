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
        description.cloudKitContainerOptions?.databaseScope = .private
        
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
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
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
    
    func deleteHabit(_ habit: Habit) -> Error? {
        let context = container.viewContext
        var error: Error? = nil
        
        let fetchRequest = NSFetchRequest<CDHabit>(entityName: "CDHabit")
        
        if let annotation = habit.annotation {
            fetchRequest.predicate = NSPredicate(format:"date = %@ AND mood = %@ AND annotation = %@", habit.date as NSDate, habit.mood.rawValue, annotation)
        }
        
        if let audio = habit.audio {
            fetchRequest.predicate = NSPredicate(format:"date = %@ AND mood = %@ AND audio = %@", habit.date as NSDate, habit.mood.rawValue, audio)
        }
        
        do {
            let cdhabits = try context.fetch(fetchRequest)
            if let deleteHabit = cdhabits.first {
                context.delete(deleteHabit)
                do{
                    try context.save()
                }catch let saveError{
                    error = saveError
                }
                
            }
        } catch let fetchError{
            error = fetchError
        }
        
        return error
    }
    
    func updateHabit(newHabit: Habit) -> Error? {
        let context = container.viewContext
        var error: Error? = nil
        
        let fetchRequest = NSFetchRequest<CDHabit>(entityName: "CDHabit")
        
        fetchRequest.predicate = NSPredicate(format:"date = %@", newHabit.date as NSDate)
        
        do {
            let cdhabits = try context.fetch(fetchRequest)
            if let updateHabit = cdhabits.first {
                updateHabit.annotation = newHabit.annotation
                updateHabit.audio = newHabit.audio
                updateHabit.mood = newHabit.mood.rawValue
                do{
                    try context.save()
                }catch let saveError{
                    error = saveError
                }
                
            }
        } catch let fetchError{
            error = fetchError
        }
        
        return error
    }
    
    func deleteHabits() {
        let context = container.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDHabit")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
        } catch  {
            debugPrint("ERROR: \(error)")
        }
        
    }
}
