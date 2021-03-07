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
            Section(header: Text("Set Notification Time")) {
                Toggle(isOn: viewModel.bidings.firstOption) {
                    Text("Every 15 minutes")
                }.disabled(viewModel.bidings.secondOption.wrappedValue || viewModel.bidings.thirdOption.wrappedValue)
                
                Toggle(isOn: viewModel.bidings.secondOption) {
                    Text("Every 30 minutes")
                }.disabled(viewModel.bidings.firstOption.wrappedValue || viewModel.bidings.thirdOption.wrappedValue)
                
                Toggle(isOn: viewModel.bidings.thirdOption) {
                    Text("Every hour")
                }.disabled(viewModel.bidings.secondOption.wrappedValue || viewModel.bidings.firstOption.wrappedValue)
            }
        }
        .navigationBarTitle("Settings")
    }
}

struct ConfigurationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConfigurationsView(viewModel: .init())
    }
}
