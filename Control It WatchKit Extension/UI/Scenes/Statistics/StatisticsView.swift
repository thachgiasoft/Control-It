//
//  StatisticsVIew.swift
//  Control It WatchKit Extension
//
//  Created by Gonzalo Ivan Santos Portales on 01/03/21.
//

import SwiftUI

struct StatisticsView: View {
    
    @ObservedObject var viewModel : StatisticsViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.init("DarkGrayColor"))
            WatchBarChart(xLabels: viewModel.xLabels, barHeights: viewModel.barHeights,backgroundColor: .init("DarkGrayColor"), labelColor: .init("watchLabelColor"))
                .onAppear {
                    withAnimation {
                        viewModel.loadAllHabits()
                    }
                }.padding(10)
                
        }
        .navigationBarTitle(Translation.ViewTitles.statistics)
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView(viewModel: .init(repository: CDHabitRepository()))
    }
}
