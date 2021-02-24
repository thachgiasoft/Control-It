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
        container = NSPersistentContainer(name: "Storage")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
    }
    
    func saveHabit(_ habit: Habit) -> Result<Habit, Error> {
        
        let context = container.viewContext
        
        let newHabit = NSEntityDescription.insertNewObject(forEntityName: "Habit", into: context) as! CDHabit
        
        newHabit.annotation = habit.annotation
        newHabit.audio = habit.audio
        newHabit.date = habit.date
        newHabit.mood = habit.mood.rawValue
        
        do {
            try context.save()
            return.success(habit)
        } catch {
            return.failure(error)
        }
        
    }
    
    func getAllHabit() -> Result<[Habit], Error> {
        
        let context = container.viewContext
        
        let fetchRequest = NSFetchRequest<CDHabit>(entityName: "Habit")
        
        do {
            let cdHabits = try context.fetch(fetchRequest)
            let habits = cdHabits.map { (cdHabit) -> Habit in
                let habit : Habit = .init(audio: cdHabit.audio, date: cdHabit.date!, mood: Mood(rawValue: cdHabit.mood!)!, annotation: cdHabit.annotation)
              return habit
                
            }
            return.success(habits)
        } catch {
            return.failure(error)
        }
    
    }
}

protocol HabitRepository {
    func saveHabit(_ habit : Habit) -> Result<Habit,Error>
    func getAllHabit() -> Result<[Habit],Error>
}
