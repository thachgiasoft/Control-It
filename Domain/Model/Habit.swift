//
//  Habit.swift
//  Control It
//
//  Created by Ingra Cristina on 24/02/21.
//

import Foundation

enum Mood : String, CaseIterable {    
    case happy
    case sad
    case tired
    case angry
    case anxious
    case bored
    //case nervous
}

struct Habit: Hashable {
    var id : String?
    var annotation : String?
    var audio : String?
    var date : Date
    var mood : Mood
    
    init(annotation : String, date : Date, mood : Mood) {
        self.annotation = annotation
        self.date = date
        self.mood = mood
    }
    
    init(audio : String, date : Date, mood : Mood) {
        self.audio = audio
        self.date = date
        self.mood = mood
    }
    
    init(audio : String?, date : Date, mood : Mood, annotation: String?) {
        self.audio = audio
        self.date = date
        self.mood = mood
        self.annotation = annotation
    }
    
    init(id: String, audio : String?, date : Date, mood : Mood, annotation: String?) {
        self.id = id
        self.audio = audio
        self.date = date
        self.mood = mood
        self.annotation = annotation
    }
}

extension Habit {
    var day : String {
        date.getLocalizedDateInComponents()[0]
    }
    
    var month : String {
        date.getLocalizedDateInComponents()[1]
    }
    
    var time : String {
        date.getLocalizedDateInComponents()[2]
    }
}

extension Date {
    func getLocalizedDateInComponents() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM HH:mm"
        return formatter.string(from: self).localizedUppercase.split{ $0 == " " }.map(String.init)
    }
}
