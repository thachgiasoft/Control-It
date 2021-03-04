//
//  AnnotationMoods.swift
//  Control It
//
//  Created by Ingra Cristina on 03/03/21.
//

import SwiftUI

struct AnnotationMoods: View {
    var body: some View {
        //NavigationView {
            VStack{
                VStack{
                    HStack {
                        Text("Humor")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .padding()
                        Spacer()
                    }
                    // imagens c nome
                    ScrollView(.horizontal) {
                        HStack(spacing: 0) {
                            ForEach(Mood.allCases, id: \.rawValue) { mood in
                                VStack {
                                    Image(mood.rawValue)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .padding(.horizontal)
                                    Text(mood.rawValue).padding(.bottom)
                                    
                                }.frame(width: UIScreen.main.bounds.width / 5)
           
                            }
                        }.padding(.horizontal)// WOEGBQUYOWEGQWUIEYGQIWYUEGQWYEUQ MT BOM, AINDA BEM QUE EU NÃO SOU TU INGRA
                    }
                    Spacer()
                    
                    VStack{
                        HStack{
                            Text("Annotations")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .padding()
                            Spacer()
                        }
                        Spacer()
                        ZStack(alignment: .top){
                            
                            HStack{
                                Spacer()
                                Spacer()
                                Spacer()
                                TextFieldAnnotation()
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
    @State private var name: String = ""

    var body: some View {
        GeometryReader { sizeReader in
            ZStack {
                RoundedRectangle(cornerRadius: 30).foregroundColor(.init(.gray))
                VStack {
                    TextField("Enter your name", text: $name)
                        .frame(width: sizeReader.size.width, height: sizeReader.size.height, alignment: .top)
                    
                }
                
            }
        }
    
    }
}

struct AnnotationMoods_Previews: PreviewProvider {
    static var previews: some View {
        AnnotationMoods()
    }
}
