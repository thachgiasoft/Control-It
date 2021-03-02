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
        }.onAppear(perform: { })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(repository: CDHabitRepository())
    }
}
