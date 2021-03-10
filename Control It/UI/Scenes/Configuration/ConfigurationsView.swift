//
//  ConfigurationsView.swift
//  Control It
//
//  Created by Gonzalo Ivan Santos Portales on 04/03/21.
//

import SwiftUI

struct ConfigurationsView: View {
    var viewModel : ConfigurationViewModel
    
    @State var firstOption : Bool
    @State var secondOption : Bool
    @State var thirdOption : Bool
    
    init(viewModel : ConfigurationViewModel) {
        self.viewModel = viewModel
        
        _firstOption = State(initialValue: viewModel.isNotificationSetOn(time: .minute15))
        _secondOption = State(initialValue: viewModel.isNotificationSetOn(time: .minute30))
        _thirdOption = State(initialValue: viewModel.isNotificationSetOn(time: .hour1))
    }

    var body: some View {
        Form {
            Section(header: Text(Translation.TextTitles.notificationTime)) {
                Toggle(isOn: $firstOption) {
                    Text(Translation.ToggleTexts.every15minutes)
                }.disabled(secondOption || thirdOption)
                .onChange(of: firstOption, perform: { value in
                    if value {
                        viewModel.prepareNotification(on: .minute15)
                    } else {
                        viewModel.removeAllPendingNotificationsFor(time: .minute15)
                    }
                })
                
                Toggle(isOn: $secondOption) {
                    Text(Translation.ToggleTexts.every30minutes)
                }.disabled(firstOption || thirdOption)
                .onChange(of: secondOption, perform: { value in
                    if value {
                        viewModel.prepareNotification(on: .minute30)
                    } else {
                        viewModel.removeAllPendingNotificationsFor(time: .minute30)
                    }
                })
                
                Toggle(isOn: $thirdOption) {
                    Text(Translation.ToggleTexts.everyHour)
                }.disabled(secondOption || firstOption)
                .onChange(of: thirdOption, perform: { value in
                    if value {
                        viewModel.prepareNotification(on: .hour1)
                    } else {
                        viewModel.removeAllPendingNotificationsFor(time: .hour1)
                    }
                })
            }
        }.background(Color(.white))
        .navigationBarTitle(Translation.ViewTitles.settings)
    }
}

struct ConfigurationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationsView(viewModel: .init())
    }
}
