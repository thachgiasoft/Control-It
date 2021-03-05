//
//  Control_ItApp.swift
//  Control It
//
//  Created by Ingra Cristina on 23/02/21.
//

import SwiftUI

@main
struct Control_ItApp: App {
    let repository = CDHabitRepository()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    HabitListView(model: .init(habitRepository: repository))
                }.tabItem {
                    Label("Registros", systemImage: "list.dash")
                }
                NavigationView {
                    StatisticsView(viewModel: .init(repository: repository))
                }.tabItem {
                    Label("Estatísticas", systemImage: "chart.bar")
                }
                NavigationView {
                    ConfigurationsView(viewModel: .init())
                }.tabItem {
                    Label("Configurações", systemImage: "list.dash")
                }
            }
        }
    }
}
