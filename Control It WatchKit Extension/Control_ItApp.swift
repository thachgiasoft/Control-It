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
                TabView {
                    MoodList()
                    RecordingView()
                    StatisticsView(viewModel: .init(repository: repository))
                }.tabViewStyle(PageTabViewStyle())
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
