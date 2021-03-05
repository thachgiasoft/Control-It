//
//  SwiftUIView.swift
//  Control It
//
//  Created by Ingra Cristina on 05/03/21.
//

import SwiftUI



struct PlayerView: View {
    let name: String

    var body: some View {
        Text("Selected player: \(name)")
            .font(.largeTitle)
    }
}

struct ContentView: View {
    let players = [
        "Roy Kent",
        "Richard Montlaur",
        "Dani Rojas",
        "Jamie Tartt",
    ]

    var body: some View {
        NavigationView {
            List(players, id: \.self) { player in
                NavigationLink(destination: PlayerView(name: player)) {
                    Text(player)
                }
            }
            .navigationTitle("Select a player")
        }
    }
}
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(name: PlayerView)    }
}
