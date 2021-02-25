//
//  ContentView.swift
//  Control It WatchKit Extension
//
//  Created by Ingra Cristina on 23/02/21.
//

import SwiftUI

struct ContentView: View {
    var repository : HabitRepository
    
    var body: some View {
        VStack {
            Text("Hello Watch!")
        }.onAppear(perform: {
            let result = repository.saveHabit(.init(audio: "audio no watch", date: .distantPast, mood: .anxious, annotation: "????"))
            
            switch result {
                case .success(let habit):
                    print(habit)
                case .failure(let error):
                    print(error)
            }
            
            /*let result = repository.getAllHabit()
            
            switch result {
                case .success(let habits):
                    print(habits)
                case .failure(let error):
                    print(error)
            }*/
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(repository: CDHabitRepository())
    }
}
