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
        }.onAppear(perform: { })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(repository: CDHabitRepository())
    }
}
