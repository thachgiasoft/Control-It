//
//  RecordingListView.swift
//  Control It
//
//  Created by Leonardo Viana on 03/03/21.
//

import SwiftUI

struct HabitListView: View {
    @ObservedObject private var model: HabitListViewModel
    
    init(model: HabitListViewModel = .init()) {
        self.model = model
        //model.getAllHabitsInCloud()
    }
    
    var body: some View {
        ScrollView {
            ForEach(Array(model.loadedHabits.enumerated()),id: \.element) { _, item in
                NavigationLink(destination: HabitDetailView(habit: item)) {
                    HabitListItem(
                        itemText: item.annotation ?? "",
                        moodImageName: item.mood.rawValue,
                        day: model.getLocalizedDateInComponents(item.date)[0],
                        month: model.getLocalizedDateInComponents(item.date)[1],
                        time: model.getLocalizedDateInComponents(item.date)[2]
                    )
                    .padding(.horizontal, 20)
                }
            }
        }
        .navigationTitle(Text(Translation.ViewTitles.records))
        .navigationBarItems(
            trailing: NavigationLink(
            destination: AnnotationMoods(),
            label: {
                Image(systemName: "square.and.pencil")
                    .foregroundColor(Color(red: 0.94, green: 0.39, blue: 0.18, opacity:1))
            })
        )
        .onAppear {
            model.getAllHabitsInCloud()
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
