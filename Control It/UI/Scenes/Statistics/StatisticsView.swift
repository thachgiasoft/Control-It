//
//  StatisticsView.swift
//  Control It
//
//  Created by Gonzalo Ivan Santos Portales on 03/03/21.
//

import SwiftUI

struct StatisticsView: View {
    @ObservedObject var viewModel : StatisticsViewModel
    
    var body: some View {
        GeometryReader { sizeReader in
            VStack(spacing: 10) {
                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 22).foregroundColor(.init("CardsBackColor"))
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(Translation.TextTitles.repeatsPerDay)
                                    .font(.system(size: 22, weight: .bold, design: .rounded))
                                    .bold()
                                    .foregroundColor(.init("titleColor"))
                                Text(viewModel.getWeekString())
                                    .font(.system(size: 14, weight: .regular, design: .rounded))
                                    .foregroundColor(.init("subtitleColor"))
                            }.padding(.leading)
                            Spacer()
                        }.padding(.vertical)
                        
                        IphoneBarChart(xLabels: viewModel.xLabels, barHeights: viewModel.barHeights,backgroundColor: .init("CardsBackColor"), labelColor: .init("titleColor"))
                            .padding(.horizontal,5)
                            .padding(.bottom)
                            .layoutPriority(1)
                        //Rectangle().background(Color(.blue))
                    }
                }//.layoutPriority(1)
                
                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 22).foregroundColor(.init("CardsBackColor"))
                    VStack {
                        HStack {
                            Text(Translation.TextTitles.frequentFeelings)
                                .font(.system(size: 22, weight: Font.Weight.bold, design: Font.Design.rounded))
                                .bold()
                                .foregroundColor(.init("titleColor"))
                                .padding(.leading)
                            Spacer()
                        }
                        
                        ForEach(Mood.allCases.dividedIntoGroups(), id: \.self) { moodList in
                            HStack {
                                ForEach(moodList, id: \.self) { mood in
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 14)
                                            .foregroundColor(.init("moodsGridCellColor"))
                                        HStack(alignment: .center){
                                            Image(mood.rawValue)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                //.padding(.top)
                                            Text("\(viewModel.moodsDict[mood]!)")
                                                .font(.system(.body, design: .rounded))
                                                .bold()
                                                .foregroundColor(.init("titleColor"))
                                                //.padding(.bottom)
                                        }.padding()
                                    }
                                }
                            }
                        }.padding(.horizontal)
                    }.padding(.vertical)
                }
            }.onAppear {
                viewModel.loadAllHabits()
            }.padding(.horizontal,20)
            .padding(.bottom,20)
            .navigationTitle(Translation.ViewTitles.statistics)
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView(viewModel: .init(repository: CDHabitRepository()))
    }
}

extension Array {
    func dividedIntoGroups(of i: Int = 3) -> [[Element]] {
        var copy = self
        var res = [[Element]]()
        while copy.count > i {
            res.append( (0 ..< i).map { _ in copy.remove(at: 0) } )
        }
        res.append(copy)
        return res
    }
}
