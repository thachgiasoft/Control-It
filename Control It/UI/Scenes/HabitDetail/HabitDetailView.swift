//
//  RegisterDetailView.swift
//  Control It
//
//  Created by Gonzalo Ivan Santos Portales on 07/03/21.
//

import SwiftUI

struct HabitDetailView: View {
    
    var viewModel : HabitDetailViewModel
    
    init(habit : Habit) {
        //self.text = newHabit.annotation!
        self.viewModel = .init(habit: habit)
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color(.init("CardsBackColor")))
            VStack {
                HStack {
                    HStack(alignment: .center) {
                        Text(viewModel.habit.day)
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.medium)
                        VStack {
                            Text(viewModel.habit.month)
                                .font(.system(.body, design: .rounded))
                            Text(viewModel.habit.time)
                                .font(.system(.footnote, design: .rounded))
                        }
                    }.foregroundColor(Color(.init("subtitles")))
                    Spacer()
                    Image(viewModel.habit.mood.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 45, maxHeight: 45)
                }.padding()
                TextEditor(text: viewModel.bindings.text)
                    .background(Color(.init("CardsBackColor")))
                    .foregroundColor(.init("subtitleColor"))
                    
            }.padding()
        }.padding()
        .navigationBarTitle(Translation.ViewTitles.review, displayMode: .inline)
        
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailView(habit: .init(annotation: "dasdas", date: Date(), mood: .sad))
    }
}
