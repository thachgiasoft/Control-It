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
        VStack() {
            Image(mood.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .padding(.all,5)
            Text(Translation.Moods.feeling(mood.rawValue).capitalized).font(.system(size: 14, weight: .regular, design: .rounded))
                .foregroundColor((selectedMood.rawValue == mood.rawValue) ? .init("titleColor") : .init("subtitleColor") )
                    //)
                //.padding(.bottom,8)//
            
        }.background((selectedMood.rawValue == mood.rawValue) ? RoundedRectangle(cornerRadius: 13)
            .foregroundColor(.init("CardsBackColor")) : RoundedRectangle(cornerRadius: 13)
                        .foregroundColor(.clear))
        .onTapGesture {
            selectedMood = mood
        }.padding(.leading)
    }
}

struct MoodCollection : View {
    @Binding var selectedMood : Mood
    
    var body : some View {
        GeometryReader { reader in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(Mood.allCases, id: \.rawValue) { mood in
                        MoodCell(selectedMood: $selectedMood, mood: mood)
                            .frame(width: reader.size.width / 5)
                    }
                    
                }
            }
        }
    }
}

struct AnnotationMoods: View {
    @Environment(\.presentationMode) var presentation
    
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
                
               
                MoodCollection(selectedMood: $selectedMood)
                    .isHidden(hideMood, remove: hideMood)
                    .frame(height: firstReader.size.height * 0.13)
                    .isHidden(hideMood, remove: hideMood)
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
                VStack {
                    HStack {
                        Text(Translation.TextTitles.annotations)
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
            presentation.wrappedValue.dismiss()
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
