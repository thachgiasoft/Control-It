//
//  ComplicationController.swift
//  Control It WatchKit Extension
//
//  Created by Ingra Cristina on 23/02/21.
//

import ClockKit
import SwiftUI

class UpdateComplicationController {
    func update() {
        if let complications = CLKComplicationServer.sharedInstance().activeComplications, let complication = complications.first {
            CLKComplicationServer.sharedInstance().reloadTimeline(for: complication)
        }
    }
}

class ComplicationController: NSObject, CLKComplicationDataSource {
    var dataController: [Habit] = []
    var repository = CDHabitRepository()
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override init() {
        super.init()
        // o init é chamado toda vez que o app dá launch, é aqui que a gente tem que fazer o update da complication
        // na vdd deveria atualizar toda vez que o app fecha, agora pra fazer isso sabe deus
        // 
//        if let complications = CLKComplicationServer.sharedInstance().activeComplications, let complication = complications.first {
//
//            CLKComplicationServer.sharedInstance().reloadTimeline(for: complication)
//        }
//        CDHabitRepository().getAllHabit { (result) in
//            switch result {
//            case .success(let habits):
//                self.dataController = habits
//            case .failure(_):
//                self.dataController = []
//            }
//        }
    }
    // MARK: - Complication Configuration

    func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
        let descriptors = [
            CLKComplicationDescriptor(identifier: "complication", displayName: "Habits Counter", supportedFamilies: [.circularSmall,.graphicCircular,.graphicCorner,.graphicExtraLarge])
            // Multiple complication support can be added here with more descriptors
        ]
        
        // Call the handler with the currently supported complication descriptors
        handler(descriptors)
    }
    
    func handleSharedComplicationDescriptors(_ complicationDescriptors: [CLKComplicationDescriptor]) {
        // Do any necessary work to support these newly shared complication descriptors
    }

    // MARK: - Timeline Configuration
    // chama primeiro
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        // Call the handler with the last entry date you can currently provide or nil if you can't support future timelines
        //handler(dataController.last?.date)
        
        
        handler(Date())
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        // Call the handler with your desired behavior when the device is locked
        handler(.showOnLockScreen)
    }

    // MARK: - Timeline Population
    // chama segundo
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Call the handler with the current timeline entry
        switch complication.family {
            case .graphicCircular:
                repository.getAllHabit { result in
                    switch result {
                    case .failure(let error):
                        print(error.localizedDescription)
                    case .success(let habits):
                        let colors = self.getComplicationColorsFrom(habits: habits)
                        let template = self.makeTemplate(complication: complication,colors: colors)
                        if let loadedTemplate = template {
                            let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: loadedTemplate)
                            handler(entry)
                        }
                    }
                }
            case .graphicCorner:
                repository.getAllHabit { result in
                    switch result {
                    case .failure(let error):
                        print(error.localizedDescription)
                    case .success(let habits):
                        let colors = self.getComplicationColorsFrom(habits: habits)
                        let template = self.makeTemplate(complication: complication,colors: colors)
                        if let loadedTemplate = template {
                            let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: loadedTemplate)
                            handler(entry)
                        }
                    }
                }
            case .circularSmall:
                repository.getAllHabit { result in
                    switch result {
                    case .failure(let error):
                        print(error.localizedDescription)
                    case .success(let habits):
                        let colors = self.getComplicationColorsFrom(habits: habits)
                        let template = self.makeTemplate(complication: complication, colors: colors)
                        if let loadedTemplate = template {
                            let entry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: loadedTemplate)
                            handler(entry)
                        }
                    }
                }
                
            default:
                handler(nil)
        }
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after the given date
        
        switch complication.family {
            case .graphicCircular:
                repository.getAllHabit { result in
                    switch result {
                    case .failure(let error):
                        print(error.localizedDescription)
                    case .success(let habits):
                        let colors = self.getComplicationColorsFrom(habits: habits)
                        let template = self.makeTemplate(complication: complication,colors: colors)
                        var entries: [CLKComplicationTimelineEntry] = []
                        if let loadedTemplate = template {
                            let entry = CLKComplicationTimelineEntry(date: date, complicationTemplate: loadedTemplate)
                            entries.append(entry)
                        }
                        handler(entries)
                    }
                }
            case .graphicCorner:
                repository.getAllHabit { result in
                    switch result {
                    case .failure(let error):
                        print(error.localizedDescription)
                    case .success(let habits):
                        let colors = self.getComplicationColorsFrom(habits: habits)
                        let template = self.makeTemplate(complication: complication,colors: colors)
                        var entries: [CLKComplicationTimelineEntry] = []
                        if let loadedTemplate = template {
                            let entry = CLKComplicationTimelineEntry(date: date, complicationTemplate: loadedTemplate)
                            entries.append(entry)
                        }
                        handler(entries)
                    }
                }
            case .circularSmall:
                repository.getAllHabit { result in
                    switch result {
                    case .failure(let error):
                        print(error.localizedDescription)
                    case .success(let habits):
                        let colors = self.getComplicationColorsFrom(habits: habits)
                        let template = self.makeTemplate(complication: complication,colors: colors)
                        var entries: [CLKComplicationTimelineEntry] = []
                        if let loadedTemplate = template {
                            let entry = CLKComplicationTimelineEntry(date: date, complicationTemplate: loadedTemplate)
                            entries.append(entry)
                        }
                        handler(entries)
                    }
                }
               
            default:
                handler(nil)
        }
}

    // MARK: - Sample Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        handler(nil)
    }
}

extension ComplicationController {
    func makeTemplate(complication: CLKComplication, colors : [Color]) -> CLKComplicationTemplate? {
        switch complication.family {
            case .graphicCircular:
                return CLKComplicationTemplateGraphicCircularView(
                    CircularComplicationView(colors: colors)
                )
            case .graphicCorner:
                return CLKComplicationTemplateGraphicCornerCircularView(
                    CircularComplicationView(colors: colors)
                )
            case .circularSmall:
                let template = CLKComplicationTemplateCircularSmallSimpleText()
                template.textProvider = CLKSimpleTextProvider(text: String(colors.count))
                return template
//                return CLKComplicationTemplateCircularSmallRingImage(
//                    imageProvider: .init(onePieceImage: .add),
//                    fillFraction: 0.1, ringStyle: .open)
            case .graphicExtraLarge:
                return CLKComplicationTemplateGraphicExtraLargeCircularView(
                    CircularComplicationView(colors: colors)
                )
            default:
              return nil
        }
    }
        
    func getComplicationColorsFrom(habits : [Habit]) -> [Color] {
        var colors: [Color] = []
        
        let habitsOfTheDay = habits.filter { habit in
            Calendar.current.isDateInToday(habit.date)
        }
        
        let orderedHabits = habitsOfTheDay.sorted { (previous, current) -> Bool in
            previous.mood.rawValue > current.mood.rawValue
        }
        
        orderedHabits.forEach { habit in
            colors.append(Color(habit.mood.rawValue))
        }
        
        return colors
    }
}
