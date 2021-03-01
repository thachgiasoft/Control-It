//
//  CustomAlert.swift
//  Control It WatchKit Extension
//
//  Created by Leonardo Viana on 01/03/21.
//

import SwiftUI

extension View {
    func customAlert(isPresented: Binding<Bool>, content: () -> CustomAlert) -> some View {
        content()
    }
    
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}

struct CustomAlert: View {
    var icon: Image?
    var text: String?
    var shouldDisappearAutomatically: Bool
    var showCancelButton: Bool
    var destructionAction: (() -> ())?
    @State private var shouldRemoveView: Bool = false
    @State private var cancelButtonTapped: Bool = false
    
    init(
        icon: Image,
        shouldDisappearAutomatically: Bool = false,
        showCancelButton: Bool = false,
        destructionAction: (() -> ())? = nil
    ) {
        self.icon = icon
        self.shouldDisappearAutomatically = shouldDisappearAutomatically
        self.showCancelButton = showCancelButton
        self.destructionAction = destructionAction
    }
    
    init(
        text: String,
        shouldDisappearAutomatically: Bool = false,
        showCancelButton: Bool = false,
        destructionAction: (() -> ())? = nil
    ) {
        self.text = text
        self.shouldDisappearAutomatically = shouldDisappearAutomatically
        self.showCancelButton = showCancelButton
        self.destructionAction = destructionAction
    }
    
    init(
        icon: Image,
        text: String,
        shouldDisappearAutomatically: Bool = false,
        showCancelButton: Bool = false,
        destructionAction: (() -> ())? = nil
    ) {
        self.icon = icon
        self.text = text
        self.shouldDisappearAutomatically = shouldDisappearAutomatically
        self.showCancelButton = showCancelButton
        self.destructionAction = destructionAction
    }
    
    var body: some View {
        ZStack {
            VStack {
                Group {
                    if showCancelButton {
                        HStack {
                            Button("Cancelar") {
                                self.shouldRemoveView = true
                            }
                            .buttonStyle(PlainButtonStyle())
                            Spacer()
                        }
                        if icon != nil || text != nil || destructionAction != nil {
                            Spacer()
                        }
                    }
                    if icon != nil {
                        icon!
                        if text != nil || destructionAction != nil {
                            Spacer()
                        }
                    }
                    if text != nil {
                        Text(text!)
                            .font(.system(.body, design: .rounded))
                            .bold()
                            .multilineTextAlignment(.center)
                        if destructionAction != nil {
                            Spacer()
                        }
                    }
                    if destructionAction != nil {
                        Button(action: {
                            destructionAction!()
                            withAnimation {
                                self.shouldRemoveView = true
                            }
                        }, label: {
                            Text("Apagar")
                                .font(.system(.body, design: .rounded))
                                .foregroundColor(.red)
                                .bold()
                        })
                    }
                }
            }
            .frame(minWidth: 0,
                   maxWidth: .infinity,
                   minHeight: 0,
                   maxHeight: .infinity,
                   alignment: .center
            )
            .background(Color.black)
        }
        .onAppear(){
            if shouldDisappearAutomatically {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation{
                        self.shouldRemoveView = true
                    }
                }
            }
        }
        .isHidden(shouldRemoveView, remove: shouldRemoveView)
        
    }
}

struct CustomAlert_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlert(icon: Image("checkRegister"), shouldDisappearAutomatically: true)
        
        //        CustomAlert(text: "A gravação será apagada permanentemente.", showCancelButton: true) {
        //            print("Preview destruction")
        //        }
    }
}
