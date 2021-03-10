//  HIstoryBarChart.swift
//  Control It WatchKit Extension
//
//  Created by Gonzalo Ivan Santos Portales on 25/02/21.
//

import SwiftUI

struct IphoneBarChart : View  {
    var xLabels : [String]
    var barHeights : [Int]
    var maxHeight : Double
    var backgroundColor : Color
    var labelColor : Color
    
    init(xLabels : [String], barHeights : [Int], backgroundColor: Color, labelColor: Color) {
    
        let aux = Double(barHeights.max() ?? 5)
        self.maxHeight = (aux == 0) ? 5 : ((aux / 5.0).rounded(.up)) * 5
        self.xLabels = xLabels
        self.barHeights = barHeights
        self.labelColor = labelColor
        self.backgroundColor = backgroundColor
    }
    
    var body : some View {
        ZStack {
            //RoundedRectangle(cornerRadius: 22)
                //.foregroundColor(backgroundColor)
            VStack {
                ForEach(0..<5) { _ in
                    Divider()
                    Spacer()
                }
                Text(" ")
                    .font(.system(size: 14, weight: .bold, design: .rounded))
            }
            
            HStack() {
                VStack() {
                    ForEach((1...5).reversed(), id: \.self) { index in
                        Text(
                            "\(Int(Double(maxHeight / 5) * Double(index)))"
                        )
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .padding(.horizontal)
                        //.font(.system(size: 14, weight: .bold, design: .rounded))
                        .animation(nil)
                        Spacer()
                    }
                    Text(" ")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .padding(.horizontal)
                }.layoutPriority(1)
                
                ForEach(0..<barHeights.count) { index in
                    VStack(spacing :0) {
                        Rectangle()
                            .fill(Color("Beige"))
                            .scaleEffect(y:CGFloat(Double(barHeights[index]) / Double(maxHeight)) ,anchor: .bottom)
                        
                        Text(xLabels[index])
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                    }
                }
            }
        }
    }
}

struct HistoryBarChart_Previews: PreviewProvider {
    static var previews: some View {
        IphoneBarChart(xLabels: ["D","S","T","Q","Q","S","S"], barHeights: [5,1,8,2,4,1,3],backgroundColor: .init("DarkGrayColor"), labelColor: .init("watchLabelColor"))
    }
}
