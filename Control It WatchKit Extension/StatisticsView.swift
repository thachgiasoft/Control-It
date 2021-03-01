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
            for habit in viewModel.habits {
                let components = Calendar.current.dateComponents([.weekday], from: habit.date)
                print(components)
            }
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView(viewModel: .init(repository: CDHabitRepository()))
    }
}
