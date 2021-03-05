//
//  ConfigurationsView.swift
//  Control It
//
//  Created by Gonzalo Ivan Santos Portales on 04/03/21.
//

import SwiftUI

struct ConfigurationsView: View {
    @State var firstOption: Bool = false
    @State var secondOption: Bool = false
    @State var thirdOption: Bool = false
    
    var viewModel : ConfigurationViewModel

    var body: some View {
        Form {
            Section(header: Text("Set Notification Time")) {
                Toggle(isOn: viewModel.firstOption) {
                    Text("Every 15 minutes")
                }.onTapGesture {
                    if viewModel.secondOption.wrappedValue {
                        viewModel.secondOption.wrappedValue = false
                    }
                    if viewModel.thirdOption.wrappedValue {
                        viewModel.thirdOption.wrappedValue = false
                    }
                }
                
                Toggle(isOn: viewModel.secondOption) {
                    Text("Every 30 minutes")
                }
                
                Toggle(isOn: viewModel.thirdOption) {
                    Text("Every hour")
                }
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
