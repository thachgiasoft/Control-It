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
                        HStack {
                            ForEach(Mood.allCases, id: \.rawValue) { mood in
                                VStack{
                                    Image(mood.rawValue)
                                    Text(mood.rawValue)
                                    
                                }
                                
                            }
                        }
                    }
                    Spacer()
                    
                    VStack{
                        HStack{
                            
                        }
                    }
                        
                }
                
            }
            
          
            
            .navigationBarTitle("Registrar", displayMode: .inline)
        
            
    }
}

struct AnnotationMoods_Previews: PreviewProvider {
    static var previews: some View {
        AnnotationMoods()
    }
}
