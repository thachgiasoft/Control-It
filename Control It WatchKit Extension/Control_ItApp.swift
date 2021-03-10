//
//  Control_ItApp.swift
//  Control It WatchKit Extension
//
//  Created by Ingra Cristina on 23/02/21.
//

import SwiftUI

@main
struct Control_ItApp: App {
    @Environment(\.scenePhase) private var scenePhase
    let repository = CDHabitRepository()
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                //TestView()
                TabView {
                    RecordingView()
                    MoodList()
                    StatisticsView(viewModel: .init(repository: repository))
                }.tabViewStyle(PageTabViewStyle())
            }.onChange(of: scenePhase, perform: { value in
                switch value {
                case .inactive :
                    UpdateComplicationController().update()
                case .background :
                    UpdateComplicationController().update()
                    print("Background")
                case .active :
                    print("Active")
                @unknown default:
                    print("sabe deus")
                }
            })
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
