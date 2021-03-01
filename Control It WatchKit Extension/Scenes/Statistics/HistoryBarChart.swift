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
    var maxHeight : CGFloat!
    var squareSize : CGFloat!
    
    init(yLabels : [Int], xLabels : [String], barHeights : [CGFloat]) {
        self.numbersOfBars = xLabels.count
        self.yLabels = yLabels.reversed()
        self.xLabels = xLabels
        self.barHeights = barHeights
        //self.maxHeight = CGFloat(barHeights.max() ?? 0)
        self.maxHeight = 20
    }
    
    var body : some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10).foregroundColor(.black)
            GeometryReader { firstReader in
                let fullHeight = firstReader.size.height
                let fullWidth = firstReader.size.width
                let lineHeight = (fullHeight - 20) / maxHeight
                
                VStack {
                    HStack {
                        VStack(spacing:0) {
                            ForEach(0..<yLabels.count - 1) { index in
                                ZStack(alignment: Alignment.top, content: {
                                    RoundedRectangle(cornerRadius: 3).foregroundColor(.black)
                                    Text("\(yLabels[index])").padding(-4)
                                }).frame(height: lineHeight * 5).padding(.leading)
                            }
                            Text("0").frame(height: 20).padding(.leading)
                        }.frame(width: fullWidth * 0.15, height: fullHeight)
                        GeometryReader { secondReader in
                            let spacingBetweenBars : CGFloat = 8
                            let barWidth = (secondReader.size.width / CGFloat(numbersOfBars)) - spacingBetweenBars
                            
                            HStack(spacing:spacingBetweenBars) {
                                ForEach(0..<numbersOfBars) { index in
                                    VStack(spacing: 0) {
                                        if barHeights[index] != maxHeight {
                                            Spacer().padding(0)
                                        }
                                        RoundedRectangle(cornerRadius: 3.5)
                                            .fill(Color.purple)
                                            .frame(width: barWidth, height: barHeights[index] * lineHeight).padding(0)
                                        Text(xLabels[index]).frame(height: 20)
                                    }
                                }
                            }
                        }.frame(width: fullWidth * 0.85, height: fullHeight)
                    }.frame(width: fullWidth, height: fullHeight)
                }
            }.padding()
        }
    }
}

struct HistoryBarChart_Previews: PreviewProvider {
    static var previews: some View {
        HistoryBarChart(yLabels: [0,5,10,15,20], xLabels: ["D","S","T","Q","Q","S","S"], barHeights: [1,0,0,0,0,20,0])
    }
}
