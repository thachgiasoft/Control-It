//
//  TestView.swift
//  Control It WatchKit Extension
//
//  Created by Gonzalo Ivan Santos Portales on 02/03/21.
//

import SwiftUI

struct TestView: View {
    let notification = UserNotificationService()
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button("taporra") {
                notification.setUserNotificationIn(minutes: 1)
                notification.getPendingNotifications { (requests) in
                    print(requests)
                }
            }
        }.onAppear {
            //notification.removeAllPendingNotifications()
            notification.askUserNotificationPermission()
            notification.getPendingNotifications { (requests) in
                print(requests)
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    } // perai
}
