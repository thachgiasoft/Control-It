//
//  ConfigurationsView.swift
//  Control It
//
//  Created by Gonzalo Ivan Santos Portales on 04/03/21.
//

import SwiftUI

struct ConfigurationsView: View {
    
    var viewModel : ConfigurationViewModel

    var body: some View {
        Form {
            Section(header: Text(Translation.TextTitles.notificationTime)) {
                Toggle(isOn: viewModel.bidings.firstOption) {
                    Text(Translation.ToggleTexts.every15minutes)
                }.disabled(viewModel.bidings.secondOption.wrappedValue || viewModel.bidings.thirdOption.wrappedValue)
                
                Toggle(isOn: viewModel.bidings.secondOption) {
                    Text(Translation.ToggleTexts.every30minutes)
                }.disabled(viewModel.bidings.firstOption.wrappedValue || viewModel.bidings.thirdOption.wrappedValue)
                
                Toggle(isOn: viewModel.bidings.thirdOption) {
                    Text(Translation.ToggleTexts.everyHour)
                }.disabled(viewModel.bidings.secondOption.wrappedValue || viewModel.bidings.firstOption.wrappedValue)
            }
        }
        .navigationBarTitle(Translation.ViewTitles.settings)
    }
}

struct ConfigurationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationsView(viewModel: .init())
    }
}
