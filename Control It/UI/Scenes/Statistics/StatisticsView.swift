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
            VStack{
                ZStack {
                    RoundedRectangle(cornerRadius: 22).foregroundColor(.init("CardsBackColor"))
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Repetições por dia")
                                    .font(.system(size: 22, weight: .bold, design: .rounded))
                                    .bold()
                                    .foregroundColor(.init("titleColor"))
                                Text("01-07 de Fev")
                                    .font(.system(size: 14, weight: .regular, design: .rounded))
                                    .foregroundColor(.init("subtitleColor"))
                            }.padding(.leading)
                        Spacer()
                        }.padding(.top)
                        HStack(alignment: .top, spacing: 0) {
                            HistoryBarChart(yLabels: viewModel.yLabels, xLabels: viewModel.xLabels, barHeights: viewModel.barHeights,backgroundColor: .init("CardsBackColor"))
                                //.frame(height: sizeReader.size.height / 2)
                            //Spacer()
                        }
                    }
                }
                
                ZStack(alignment: .top) {
                    RoundedRectangle(cornerRadius: 22).foregroundColor(.init("CardsBackColor"))
                    VStack {
                        HStack {
                            Text("Humores Frequentes:")
                                .font(.system(size: 22, weight: Font.Weight.bold, design: Font.Design.rounded))
                                .bold()
                                .foregroundColor(.init("titleColor"))
                                .padding(.leading)
                            Spacer()
                        }
                        LazyVGrid(columns: [.init(.flexible()),.init(.flexible()),.init(.flexible()),.init(.flexible())],
                                  spacing:5
                        ) {
                            ForEach(viewModel.moodsDict.map({ (key: Mood, value: Int) -> Mood in
                                return key
                            }), id: \.rawValue) { mood in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 14)
                                        .foregroundColor(.init("moodsGridCellColor"))
                                    VStack {
                                        Image(mood.rawValue)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .padding(.top)
                                        Text("\(viewModel.moodsDict[mood]!)")
                                            .font(.system(.body, design: .rounded))
                                            .bold()
                                            .foregroundColor(.init("titleColor"))
                                            .padding(.bottom)
                                    }.padding(.horizontal)
                                }
                            }
                        }.padding(.horizontal)
                    }.padding(.vertical)
                }
            }.onAppear {
                viewModel.loadAllHabits()
            }.padding(10)
            .navigationTitle("Estatísticas")
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView(viewModel: .init(repository: CDHabitRepository()))
    }
}