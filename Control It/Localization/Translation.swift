//
//  Translation.swift
//  Control It
//
//  Created by Leonardo Viana on 05/03/21.
//

import Foundation

public class Translation {
    public class ViewTitles {
        static let records = NSLocalizedString("Records", comment: "")
        static let record = NSLocalizedString("Record", comment: "")
        static let statistics = NSLocalizedString("Statistics", comment: "")
        static let settings = NSLocalizedString("Settings", comment: "")
        static let review = NSLocalizedString("Review", comment: "")
    }
    
    public class TextTitles {
        static let mood = NSLocalizedString("Mood", comment: "")
        static let annotations = NSLocalizedString("Annotations", comment: "")
        static let repeatsPerDay = NSLocalizedString("Repeats per day", comment: "")
        static let frequentFeelings = NSLocalizedString("Frequent feelings", comment: "")
        static let notificationTime = NSLocalizedString("Notifications time", comment: "")
    }
    
    public class Conectives {
        static let of = NSLocalizedString("of", comment: "")
    }
    
    public class NotificationTexts {
        static let subtitle = NSLocalizedString("NotificationSubtitle", comment: "")
    }
    
    public class Moods {
        static func feeling(_ value: String) -> String{
            return NSLocalizedString(value, comment: "")
        }
    }
    
    public class Placeholders {
        static let typeHere = NSLocalizedString("Type here", comment: "")
        static let save = NSLocalizedString("Save", comment: "")
    }
    
    public class ToggleTexts {
        static let every15minutes = NSLocalizedString("Every 15 minutes", comment: "")
        static let every30minutes = NSLocalizedString("Every 30 minutes", comment: "")
        static let everyHour = NSLocalizedString("Every hour", comment: "")
    }
    
    public class ActionSheet {
        static let message = NSLocalizedString("What do you want to do?", comment: "")
        static let save = NSLocalizedString("Save changes", comment: "")
        static let remove = NSLocalizedString("Remove permanently", comment: "")
    }
}
