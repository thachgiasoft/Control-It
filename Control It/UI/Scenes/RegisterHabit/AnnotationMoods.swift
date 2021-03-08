//
//  AnnotationMoods.swift
//  Control It
//
//  Created by Ingra Cristina on 03/03/21.
//

import SwiftUI

struct MoodCell : View {
    @Binding var selectedMood : Mood
    var mood : Mood
    
    var body : some View {
        
        ZStack {
            if  selectedMood == mood {
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .padding(.init(top: -5, leading: 0.0, bottom: 0.0, trailing: 0.0))
                }
                
            }
            VStack {
                Image(mood.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal)
                Text(Translation.Moods.feeling(mood.rawValue).capitalized).padding(.bottom)
                
            }
        }.onTapGesture {
            selectedMood = mood
        }
    }
}

struct MoodCollection : View {
    @Binding var selectedMood : Mood
    
    var body : some View {
        GeometryReader { reader in
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(Mood.allCases, id: \.rawValue) { mood in
                        MoodCell(selectedMood: $selectedMood, mood: mood)
                            .frame(width: reader.size.width / 5)
                    }
                    
                }.padding(.horizontal)
            }
        }
    }
}

struct AnnotationMoods: View {
    @State var text = Translation.Placeholders.typeHere
    @State var hideMood: Bool = false
    @State var selectedMood = Mood.angry // dps eu tento ver como passar isso pra view model pq tá foda
    
    var viewModel : RegisterHabitViewModel
    
    init(viewModel : RegisterHabitViewModel = .init(repository: CDHabitRepository())) {
        UITextView.appearance().backgroundColor = .clear // precisa fazer essa porra pra poder trocar a cor do text editor, pqp
        self.viewModel = viewModel
    }
    
    var body: some View {
        //NavigationView {
        GeometryReader { firstReader in
        VStack {
            VStack {
                HStack {
                    Text(Translation.TextTitles.mood)
                        .font(.system(size: 22, weight: Font.Weight.bold, design: Font.Design.rounded))
                        .bold()
                        .padding()
                    Spacer()
                    
                }.isHidden(hideMood, remove: hideMood)
                // imagens c nome
                
                GeometryReader { secondReader in
                    MoodCollection(selectedMood: $selectedMood)
                    .isHidden(hideMood, remove: hideMood)
                }.frame(height: firstReader.size.height * 0.13).isHidden(hideMood, remove: hideMood)
                Spacer()
                
                VStack {
                    HStack {
                        Text(Translation.TextTitles.mood)
                            .font(.system(size: 22, weight: Font.Weight.bold, design: Font.Design.rounded))
                            .bold()
                            .padding(.horizontal)
                        Spacer()
                    }
                    ZStack(alignment: .top) {
                        HStack {
                            Spacer()
                            Spacer()
                            Spacer()
                            HStack {
                                TextFieldAnnotation(text: $text, hideMood:$hideMood)
                                }
                            Spacer()
                            Spacer()
                            Spacer()
                            }
                            
                        }
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                }
            }
            .onTapGesture {
                withAnimation {
                    hideMood.toggle()
                }
        }
        }
        .navigationBarTitle(Translation.ViewTitles.record, displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            let habit = Habit(annotation: text, date: Date(), mood: selectedMood)
            
            viewModel.saveHabit(habit)
        }, label: {
            Text("Save")
        }))
        }
    }

struct TextFieldAnnotation: View {
    //@State private var text: String = Translation.Placeholders.typeHere
    @Binding var text : String
    @Binding var hideMood: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color(.init("CardsBackColor")))
            VStack {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $text)
                        .font(.system(.body, design: .rounded))
                        .background(Color(.init("CardsBackColor")))
                        
                        .foregroundColor(.init("subtitleColor"))
                        .onTapGesture {
                            withAnimation {
                                hideMood.toggle()
                                
                            }
                            if self.text == Translation.Placeholders.typeHere {
                                self.text = ""
                            }
                        }
                }
            }.padding()
        }
    }
}

struct AnnotationMoods_Previews: PreviewProvider {
    static var previews: some View {
        AnnotationMoods()
    }
}
