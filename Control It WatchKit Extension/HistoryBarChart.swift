//  HIstoryBarChart.swift
//  Control It WatchKit Extension
//
//  Created by Gonzalo Ivan Santos Portales on 25/02/21.
//

import SwiftUI

struct HistoryBarChart : View  {
    var numbersOfBars : Int!
    var yLabels : [Int]!
    var xLabels : [String]!
    var barHeights : [CGFloat]!
    var maxHeight : Double!
    var squareSize : CGFloat!
    
    init(yLabels : [Int], xLabels : [String], barHeights : [CGFloat]) {
        self.numbersOfBars = xLabels.count
        self.yLabels = yLabels.reversed()
        self.xLabels = xLabels
        self.barHeights = barHeights
        self.maxHeight = Double(barHeights.max() ?? 0)
    }
    
    var body : some View {
        GeometryReader { firstReader in
            let fullHeight = firstReader.size.height
            let fullWidth = firstReader.size.width
            let lineHeight = (fullHeight - 20) / CGFloat(maxHeight)
            
            VStack {
                HStack {
                    VStack(spacing:0) {
                        ForEach(0..<yLabels.count - 1) { index in
                            ZStack(alignment: Alignment.top, content: {
                                Rectangle().foregroundColor(.black)
                                Text("\(yLabels[index])").padding(-3)
                            }).frame(height: lineHeight * 5)
                        }
                        Text("0").frame(height: 20)
                    }.frame(width: fullWidth * 0.15, height: fullHeight)
                    GeometryReader { secondReader in
                        let spacingBetweenBars : CGFloat = 8
                        let barWidth = (secondReader.size.width / CGFloat(numbersOfBars)) - spacingBetweenBars
                        
                        HStack(spacing:spacingBetweenBars) {
                            ForEach(0..<numbersOfBars) { index in
                                VStack(spacing: 0) {
                                    if barHeights[index] != CGFloat(maxHeight) {
                                        Spacer().padding(0)
                                    }
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.purple)
                                        .frame(width: barWidth, height: barHeights[index] * lineHeight).padding(0)
                                    Text(xLabels[index]).frame(height: 20)
                                }
                            }
                        }
                    }.frame(width: fullWidth * 0.85, height: fullHeight)
                }.frame(width: fullWidth, height: fullHeight)
            }
        }
    }
}

struct HistoryBarChart_Previews: PreviewProvider {
    static var previews: some View {
        HistoryBarChart(yLabels: [0,5,10,15,20], xLabels: ["D","S","T","Q","Q","S","S"], barHeights: [5,10,10,15,20,19,1])
    }
}
