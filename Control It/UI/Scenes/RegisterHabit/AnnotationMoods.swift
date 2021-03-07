//
//  AnnotationMoods.swift
//  Control It
//
//  Created by Ingra Cristina on 03/03/21.
//

import SwiftUI

struct AnnotationMoods: View {
    @State var text = ""
    @State var hideMood: Bool = false
    
    init() {
        UITextView.appearance().backgroundColor = .clear // precisa fazer essa porra pra poder trocar a cor do text editor, pqp
    }
    
    var body: some View {
        //NavigationView {
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
                ScrollView(.horizontal) {
                    HStack(spacing: 0) {
                        ForEach(Mood.allCases, id: \.rawValue) { mood in
                            VStack {
                                Image(mood.rawValue)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.horizontal)
                                Text(Translation.Moods.feeling(mood.rawValue).capitalized).padding(.bottom)
                                
                            }.frame(width: UIScreen.main.bounds.width / 5)
                            
                        }
                    }.padding(.horizontal)
                }.isHidden(hideMood, remove: hideMood)
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
                            TextFieldAnnotation().onTapGesture {
                                withAnimation {
                                    hideMood.toggle()
                                }
                            }
                            Spacer()
                            Spacer()
                            Spacer()
                        }
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                }
            }
        }
        .navigationBarTitle(Translation.ViewTitles.record, displayMode: .inline)
    }
}
struct TextFieldAnnotation: View {
    @State private var text: String = Translation.Placeholders.typeHere
    
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
