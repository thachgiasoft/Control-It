//
//  StatisticsVIew.swift
//  Control It WatchKit Extension
//
//  Created by Gonzalo Ivan Santos Portales on 01/03/21.
//

import SwiftUI

struct StatisticsView: View {
    
    var viewModel : StatisticsViewModel
    
    var body: some View {
        HistoryBarChart(yLabels: viewModel.yLabels, xLabels: viewModel.xLabels, barHeights: viewModel.barHeights).onAppear {
            viewModel.loadAllHabits()
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView(viewModel: .init(repository: CDHabitRepository()))
    }
}
