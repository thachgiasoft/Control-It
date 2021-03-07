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
                        Text("Humor")
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
                                    Text(mood.rawValue.capitalized).padding(.bottom)
                                    
                                }.frame(width: UIScreen.main.bounds.width / 5)
           
                            }
                        }.padding(.horizontal)
                    }.isHidden(hideMood, remove: hideMood)
                    Spacer()
                
                    VStack {
                        HStack {
                            Text("Annotations")
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
            .navigationBarTitle("Registrar", displayMode: .inline)
    }
}
struct TextFieldAnnotation: View {
    @State private var name: String = "dasdad"

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(Color(.init("CardsBackColor")))
            VStack {
                TextEditor(text: $name)
                    .background(Color(.init("CardsBackColor")))
                    .foregroundColor(.init("subtitleColor"))
                    
            }.padding()
        }
    }
}

struct AnnotationMoods_Previews: PreviewProvider {
    static var previews: some View {
        AnnotationMoods()
    }
}
