//
//  UserConfigurationRepository.swift
//  Control It
//
//  Created by Gonzalo Ivan Santos Portales on 04/03/21.
//

import Foundation

enum UserNotificationTimeKeys : String,CaseIterable {
    case minute15
    case minute30
    case hour1
    case custom
}

class UserConfigurationRepository {
    private var defaultContainer : UserDefaults
    
    init(container : UserDefaults = .init()) {
        self.defaultContainer = container
        
        if let _ = container.value(forKey: "firstTime") {
            
        } else {
            initUserData()
        }
    }
    
    func initUserData() {
        for key in UserNotificationTimeKeys.allCases {
            saveNotification(value: false, for: key)
        }
    }
    
    func saveNotification(value : Bool, for key : UserNotificationTimeKeys) {
        defaultContainer.setValue(value, forKey: key.rawValue)
    }

    func getNotificationValue(for key : UserNotificationTimeKeys) -> Bool {
        if let value = defaultContainer.value(forKey: key.rawValue) as? Bool {
            return value
        }
        
        return false
    }
}
