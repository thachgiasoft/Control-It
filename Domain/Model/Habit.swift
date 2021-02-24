//
//  Habit.swift
//  Control It
//
//  Created by Ingra Cristina on 24/02/21.
//

import Foundation

enum Mood : String {
    case happy
    case sad
    case tired
    case angry
    case anxious
    case bored
    case nervous
}

class Habit {
    var annotation : String?
    var audio : String?
    var date : Date
    //var gesture : String?
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
}
 
