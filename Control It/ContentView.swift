//
//  ContentView.swift
//  Control It
//
//  Created by Ingra Cristina on 24/02/21.
//

import SwiftUI

struct ContentView: View {

    var repository : HabitRepository
    
    var body: some View {
        VStack {
            Text("Hello Iphone!")
        }.onAppear(perform: {
            let result = repository.saveHabit(.init(audio: "dasda", date: .distantPast, mood: .anxious, annotation: "cu é"))
            
            switch result {
                case .success(let habit):
                    print(habit)
                case .failure(let error):
                    print(error)
            }
            
            /*let result = repository.getAllHabit()
            
            switch result {
                case .success(let habit):
                    print(habit)
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
