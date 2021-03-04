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
            StatisticsView(viewModel: .init(repository: repository))
        }
    }
}
