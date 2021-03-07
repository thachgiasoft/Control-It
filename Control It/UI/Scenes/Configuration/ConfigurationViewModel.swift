//
//  ConfigurationViewModel.swift
//  Control It
//
//  Created by Gonzalo Ivan Santos Portales on 04/03/21.
//

import Foundation
import SwiftUI

struct ConfigurationViewModelStates {
    var firstOption = false
    var secondOption = false 
    var thirdOption = false
}

class ConfigurationViewModel : ObservableObject {
    
    @Published private(set) var states : ConfigurationViewModelStates = .init()
    private var notificationService : UserNotificationService
    private var userConfigurationsRepository : UserConfigurationRepository
    
    var bidings : (
        firstOption : Binding<Bool>,
        secondOption : Binding<Bool>,
        thirdOption : Binding<Bool>
    ) {(
        firstOption : Binding(
            get: {self.states.firstOption},
            set: {
                //self.removeAllPendingNotifications()
                self.states.firstOption = $0
//                    if $0 {
//                        self.states.secondOption = false
//                        self.states.thirdOption = false
//                        //self.setNotificationOn(time: 15)
//                        //self.userConfigurationsRepository.saveNotification(value: $0, for: .minute15)
//                    }
        }),
        secondOption :
            Binding(
                get: {self.states.secondOption},
                set: {
                    //self.removeAllPendingNotifications()
                    self.states.secondOption = $0
//                    if $0 {
//                        self.states.firstOption = false
//                        self.states.thirdOption = false
//                        //self.setNotificationOn(time: 30)
//                        //self.userConfigurationsRepository.saveNotification(value: $0, for: .minute30)
//                    }
            }),
        thirdOption :
            Binding(
                get: {self.states.thirdOption},
                set: {
                    //self.removeAllPendingNotifications()
                    self.states.thirdOption = $0
//                    if $0 {
//                        self.states.firstOption = false
//                        self.states.secondOption = false
//                        //self.setNotificationOn(time: 60)
//                        //self.userConfigurationsRepository.saveNotification(value: $0, for: .hour1)
//                    }
            })
    )}

    init(notificationService : UserNotificationService = .init(), userConfigurationsRepository : UserConfigurationRepository = .init()) {
        self.notificationService = notificationService
        self.userConfigurationsRepository = userConfigurationsRepository
    }
    
    func setNotificationOn(time : Int) {
        notificationService.setUserNotificationIn(minutes: time)
    }
    
    func removeAllPendingNotifications() {
        notificationService.removeAllPendingNotifications()
    }
}