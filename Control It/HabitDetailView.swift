//
//  RegisterDetailView.swift
//  Control It
//
//  Created by Gonzalo Ivan Santos Portales on 07/03/21.
//

import SwiftUI

struct HabitDetailView: View {
    
    @State var text = "qweuoygwqeuoyqgweiquetfvqwteyqfweytqefwqueytfvqhgvwd yasdvausjhdavusbdaoludb qwiuquwieh8qwueiqegoqwiueqweqweqweqweqww"
    var habit : Habit
    
    init(habit : Habit) {
        self.habit = habit
        self.text = habit.annotation!
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color(.init("CardsBackColor")))
            VStack {
                HStack {
                    HStack(alignment: .center) {
                        Text("17")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.medium)
                        VStack {
                            Text("Jan")
                                .font(.system(.body, design: .rounded))
                            Text("1009")
                                .font(.system(.footnote, design: .rounded))
                        }
                    }
                    Spacer()
                    Image(habit.mood.rawValue)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 45, maxHeight: 45)
                }.padding()
                TextEditor(text: $text)
                    .background(Color(.init("CardsBackColor")))
                    .foregroundColor(.init("subtitleColor"))
                    
            }.padding()
        }.padding()
        .navigationBarTitle("Registro", displayMode: .inline)
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetailView(habit: .init(annotation: "dasdas", date: Date(), mood: .sad))
    }
}
