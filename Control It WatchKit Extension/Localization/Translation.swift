//
//  Translation.swift
//  Control It WatchKit Extension
//
//  Created by Leonardo Viana on 04/03/21.
//

import Foundation

class Translation {
    class Texts {
        static let deletionWarning = NSLocalizedString("Permanently deletion of recording", comment: "")
        static let noRecordingsAvailable = NSLocalizedString("No recordings", comment: "")
        static let recording = NSLocalizedString("Recording", comment: "")
        static let askAboutUserFeeling = NSLocalizedString("How are you feeling", comment: "")
        static let markedHabitWarning = NSLocalizedString("Marked Habit", comment: "")
        static let recordMood = NSLocalizedString("Record mood with audio", comment: "")
    }
    
    class Buttons {
        static let delete = NSLocalizedString("Delete", comment: "")
        static let cancel = NSLocalizedString("Cancel", comment: "")
        static let recordMood = NSLocalizedString("Record Mood", comment: "")
        static let close = NSLocalizedString("Close", comment: "")
    }
    
    class Links {
        static let recordings = NSLocalizedString("Recordings", comment: "")
    }
    
    class Moods {
        static func feeling(_ value: String) -> String{
            return NSLocalizedString(value, comment: "")
        }
    }
}
