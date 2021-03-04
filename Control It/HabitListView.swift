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

struct HabitListItem: View {
    var itemText: String
    var moodImageName: String
    var day: String
    var month: String
    var time: String
    
    var body: some View {
        VStack {
            HStack {
                
                HStack(alignment: .center) {
                    Text(day)
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.medium)
                    VStack {
                        Text(month)
                            .font(.system(.body, design: .rounded))
                        Text(time)
                            .font(.system(.footnote, design: .rounded))
                    }
                }
                Spacer()
                Image(moodImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 40, maxHeight: 40)
            }
            .padding(.bottom, 5)
            .foregroundColor(Color(red: 0.30, green: 0.30, blue: 0.30, opacity: 1))
            HStack {
                Text(itemText)
                    .lineLimit(3)
                    .font(.system(.callout, design: .rounded))
                    .padding(.trailing, 24)
                    .foregroundColor(Color(red: 0.42, green: 0.42, blue: 0.42, opacity: 1))
                Spacer()
            }
        }
        .padding()
        .background(Color(red: 0.96, green: 0.97, blue: 0.97, opacity: 1))
        .cornerRadius(22)
    }
}

struct HabitListView: View {
    @ObservedObject private var model: HabitListViewModel
    
    init(model: HabitListViewModel = .init()) {
        self.model = model
        model.getAllHabitsInCloud()
    }
    
    var body: some View {
        ScrollView {
            ForEach(Array(model.loadedHabits.enumerated()),id: \.element) { _, item in
                NavigationLink(destination: AnnotationMoods()) {
                    HabitListItem(
                        itemText: item.annotation ?? "",
                        moodImageName: item.mood.rawValue,
                        day: model.getLocalizedDateInComponents(item.date)[0],
                        month: model.getLocalizedDateInComponents(item.date)[1],
                        time: model.getLocalizedDateInComponents(item.date)[2]
                    )
                    .padding(.bottom, 5)
                }
            }
            .navigationTitle(Text("Registros"))
            .navigationBarItems(trailing: Button(action: {
            }, label: {
                Image(systemName: "square.and.pencil")
                    .foregroundColor(Color(red: 0.94, green: 0.39, blue: 0.18, opacity: 1))
            }))
        }
    }
    
    struct HabitListView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationView {
                HabitListView()
            }
        }
    }
}
