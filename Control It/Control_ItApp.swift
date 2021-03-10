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
    
    init() {
        // setando uma aparencia pra botar em todas as statusBar
        //repository.deleteHabits()
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(.init("titleColor"))]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(.init("titleColor"))]
        navBarAppearance.backgroundColor = UIColor(.init("navbarColor"))
        
        // setando em todos os tipos de statusBar que existem
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().standardAppearance = navBarAppearance

        // isso aqui sabe deus
        UINavigationBar.appearance().clipsToBounds = true // pra ficar com uma aparencia flat
        //UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = UIColor(.init("navbarColor"))
    }
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationView {
                    HabitListView(model: .init(habitRepository: repository))
                }.tabItem {
                    Label(Translation.ViewTitles.records, systemImage: "list.dash")
                }
                NavigationView {
                    StatisticsView(viewModel: .init(repository: repository))
                }.tabItem {
                    Label(Translation.ViewTitles.statistics, systemImage: "chart.bar")
                }
                NavigationView {
                    ConfigurationsView(viewModel: .init())
                }.tabItem {
                    Label(Translation.ViewTitles.settings, systemImage: "gear")
                }
            }.accentColor(.orange)
        }
    }
}
