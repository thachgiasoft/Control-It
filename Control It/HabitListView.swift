//
//  RecordingListView.swift
//  Control It
//
//  Created by Leonardo Viana on 03/03/21.
//

import SwiftUI

let fakeRecordings: [Habit] = [
    .init(annotation: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris ut diam a nulla tincidunt venenatis eu vel turpis.", date: Date(), mood: .angry),
    .init(annotation: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", date: Date(), mood: .anxious),
    .init(annotation: "Lorem ipsum dolor sit amet", date: Date(), mood: .bored),
    .init(annotation: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris ut diam a nulla tincidunt venenatis eu vel turpis. Donec ut magna lectus. Ut eget bibendum enim. Integer ac diam vitae leo scelerisque scelerisque. Maecenas velit lectus, sollicitudin a purus non, blandit tincidunt enim. Proin vitae dapibus nisi. Donec vitae iaculis odio.", date: Date(), mood: .happy),
    .init(annotation: "Vivamus mauris diam, mattis eu sodales pulvinar, cursus ut lorem. Nulla non auctor mauris. Donec luctus diam et iaculis ultricies. Maecenas pulvinar vehicula cursus. Sed semper feugiat massa eget lacinia. Etiam sem dolor, mollis nec ex quis, lobortis vehicula tortor.", date: Date(), mood: .sad),
    .init(annotation: "Vivamus mauris diam, mattis eu sodales pulvinar, cursus ut lorem.", date: Date(), mood: .tired)
]

struct RecordingListView: View {
    var body: some View {
        List {
            
        }
        .navigationTitle(Text("Registros"))
        .navigationBarItems(trailing: Button(action: {
            
        }, label: {
            Image(systemName: "square.and.pencil")
                .foregroundColor(Color(red: 0.94, green: 0.39, blue: 0.18, opacity: 1))
        }))
    }
}

struct RecordingListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecordingListView()
        }
        .preferredColorScheme(.light)
    }
}
