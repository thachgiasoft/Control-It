//  HIstoryBarChart.swift
//  Control It WatchKit Extension
//
//  Created by Gonzalo Ivan Santos Portales on 25/02/21.
//

import SwiftUI

struct WatchBarChart : View  {
    var xLabels : [String]
    var barHeights : [Int]
    var maxHeight : Double
    var backgroundColor : Color
    var labelColor : Color
    var labelSize : CGFloat = 14
    
    init(xLabels : [String], barHeights : [Int], backgroundColor: Color, labelColor: Color) {
        
        let aux = Double(barHeights.max() ?? 5)
        self.maxHeight = (aux == 0) ? 5 : ((aux / 5.0).rounded(.up)) * 5
        //self.maxHeight = (aux > 5) ? aux : 5
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
                Text(" ").font(.system(size: labelSize, weight: .bold, design: .rounded))
            }
            
            HStack() {
                VStack() {
                    ForEach((1...5).reversed(), id: \.self) { index in
                        Text(
                            "\(Int(Double(maxHeight / 5) * Double(index)))"
                        )
                        .font(.system(size: labelSize, weight: .bold, design: .rounded))
                        .padding(.leading)
                        //.font(.system(size: 14, weight: .bold, design: .rounded))
                        .animation(nil)
                        Spacer()
                    }
                    Text(" ").font(.system(size: labelSize, weight: .bold, design: .rounded))
                }.layoutPriority(1)
                
                ForEach(0..<barHeights.count) { index in
                    VStack(spacing :0) {
                        Rectangle()
                            .fill(Color("Beige"))
                            .scaleEffect(y:CGFloat(Double(barHeights[index]) / Double(maxHeight)) ,anchor: .bottom)
                        
                        Text(xLabels[index])
                            .font(.system(size: labelSize, weight: .bold, design: .rounded))
                    }
                }
            }
        }
    }
}

struct HistoryBarChart_Previews: PreviewProvider {
    static var previews: some View {
        WatchBarChart(xLabels: ["D","S","T","Q","Q","S","S"], barHeights: [11,6,5,4,3,2,1],backgroundColor: .init("DarkGrayColor"), labelColor: .init("watchLabelColor"))
    }
}
