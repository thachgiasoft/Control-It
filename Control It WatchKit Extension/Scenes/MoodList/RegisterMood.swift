//
//  RegisterMood.swift
//  Control It WatchKit Extension
//
//  Created by Ingra Cristina on 26/02/21.
//

import SwiftUI

struct RegisterMood: View {
    var body: some View {
        VStack {
            Image("checkRegister")
                .offset()
                .padding()

                Text("string!")
                   // .padding()
                    .font(.largeTitle)
                    .padding()
            
           // Text("Continue a nadar!")
               // .padding()
            Button("OK!") {
                // your action here
            }
            //.padding()
                
        }
    }
}

struct RegisterMood_Previews: PreviewProvider {
    static var previews: some View {
        RegisterMood()
    }
}
