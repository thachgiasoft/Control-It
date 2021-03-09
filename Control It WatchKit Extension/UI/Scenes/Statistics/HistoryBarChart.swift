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
    var backgroundColor : Color
    var labelColor : Color
    
    init(yLabels : [Int], xLabels : [String], barHeights : [CGFloat], backgroundColor: Color, labelColor: Color) {
        self.numbersOfBars = xLabels.count
        self.yLabels = yLabels.reversed()
        self.xLabels = xLabels
        self.barHeights = barHeights
        //self.maxHeight = CGFloat(barHeights.max() ?? 0)
        self.maxHeight = 20
        self.backgroundColor = backgroundColor
        self.labelColor = labelColor
    }
    
    var body : some View {
        ZStack {
            RoundedRectangle(cornerRadius: 22)
                .foregroundColor(backgroundColor)
            GeometryReader { firstReader in
                let fullHeight = firstReader.size.height
                let fullWidth = firstReader.size.width
                let lineHeight = (fullHeight - 20 - 4) / maxHeight
                
                VStack {
                    HStack {
                        VStack(spacing:0) {
                            ForEach(0..<yLabels.count ) { index in
                                ZStack(alignment: Alignment.top, content: {
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundColor(backgroundColor)
                                    Text("\(yLabels[index])").font(.body)
                                        .fontWeight(.semibold)
                                        .padding(-4)
                                        .foregroundColor(labelColor)
                                }).frame(height: lineHeight * 5)
                            }
                            
                        }.frame(width: fullWidth * 0.10, height: fullHeight)
                        GeometryReader { secondReader in
                            let spacingBetweenBars : CGFloat = 8
                            let barWidth = (secondReader.size.width / CGFloat(numbersOfBars)) - spacingBetweenBars
                            
                            HStack(spacing:spacingBetweenBars) {
                                ForEach(0..<numbersOfBars) { index in
                                    VStack(alignment: .center,spacing: 0) {
                                        if barHeights[index] != maxHeight {
                                            Spacer().padding(0)
                                        }
                                        RoundedRectangle(cornerRadius: 5)
                                            .fill(Color.init("Beige"))
                                            .frame(width: barWidth, height: barHeights[index] * lineHeight).padding(0)
                                        Text(xLabels[index]).font(.body)
                                            .fontWeight(.semibold)
                                            .foregroundColor(labelColor)
                                            .frame(height: 20)
                                            .padding(.top,4)
                                    }
                                }
                            }
                        }.frame(width: fullWidth * 0.90, height: fullHeight)
                    }.frame(width: fullWidth, height: fullHeight)
                }
            }.padding()
        }
    }
}

struct HistoryBarChart_Previews: PreviewProvider {
    static var previews: some View {
        HistoryBarChart(yLabels: [0,5,10,15,20], xLabels: ["D","S","T","Q","Q","S","S"], barHeights: [5,1,0,0,20,0],backgroundColor: .init("DarkGrayColor"), labelColor: .init("watchLabelColor"))
    }
}
