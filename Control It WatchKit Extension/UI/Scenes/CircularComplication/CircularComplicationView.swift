//
//  CircularComplicationView.swift
//  Control It WatchKit Extension
//
//  Created by Leonardo Viana on 09/03/21.
//

import SwiftUI
import ClockKit

struct CircularComplicationView: View {
    var colors : [Color]
    
    var body: some View {
        let gradientColors = Gradient(colors: colors.count > 0 ? colors : [.white])
        let conic = LinearGradient(gradient: gradientColors, startPoint: .topLeading, endPoint: .topTrailing)
        
        return ZStack(alignment: .center) {
            Circle()
                .stroke(conic, lineWidth: 10)
            Text("\(colors.count)x")
                .font(.system(.title3, design: .rounded))
        }
    }
}

struct CircularComplicationView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CLKComplicationTemplateGraphicCircularView(
                CircularComplicationView(colors: [.gray,.gray,.red])
            ).previewContext()
        }
    }
}
