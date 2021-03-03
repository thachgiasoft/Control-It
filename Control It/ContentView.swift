//
//  ContentView.swift
//  Control It
//
//  Created by Ingra Cristina on 24/02/21.
//

import SwiftUI

struct ContentView: View {

    var repository : HabitRepository
    
    init(repository: HabitRepository = CDHabitRepository()) {
        self.repository = repository
    }
    
    var body: some View {
        VStack {
        }.onAppear(perform: {
            let habit: Habit = .init(annotation: "", date: Date(), mood: .happy)
            self.repository.saveHabit(habit) { result in
                switch result {
                case .success(_):
                    print("\n\nSUCESSO SALVANDO HABITO\n\n")
                case .failure(let error):
                    print("\n\nERRO SALVANDO HABITO\n\n \(error)")
                }
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(repository: CDHabitRepository())
    }
}
