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
    }
    
    public class Moods {
        static func feeling(_ value: String) -> String{
            return NSLocalizedString(value, comment: "")
        }
    }
    
    public class Placeholders {
        static let typeHere = NSLocalizedString("Type here", comment: "")
    }
}
