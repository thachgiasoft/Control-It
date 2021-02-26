//
//  Control_ItApp.swift
//  Control It WatchKit Extension
//
//  Created by Ingra Cristina on 23/02/21.
//

import SwiftUI

@main
struct Control_ItApp: App {
    let repository = CDHabitRepository()
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                RecordingView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
