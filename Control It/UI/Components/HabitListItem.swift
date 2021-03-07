//
//  HabitListItem.swift
//  Control It
//
//  Created by Leonardo Viana on 07/03/21.
//

import SwiftUI

struct HabitListItem: View {
    var itemText: String
    var moodImageName: String
    var day: String
    var month: String
    var time: String
    
    var body: some View {
        VStack {
            HStack {
                HStack(alignment: .center) {
                    Text(day)
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.medium)
                    VStack {
                        Text(month)
                            .font(.system(.body, design: .rounded))
                        Text(time)
                            .font(.system(.footnote, design: .rounded))
                    }
                }
                Spacer()
                Image(moodImageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 40, maxHeight: 40)
            }
            .padding(.bottom, 5)
            .foregroundColor(Color(.init("subtitles")))
            HStack {
                Text(itemText)
                    .lineLimit(3)
                    .font(.system(.callout, design: .rounded))
                    .padding(.trailing, 24)
                    .foregroundColor(Color(.init("subtitles")))
                Spacer()
            }
        }
        .padding()
        .background(Color(.init("CardsBackColor")))
        .cornerRadius(22)
    }
}

struct HabitListItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HabitListItem(itemText: "Lorem ipsum dolor sit amet", moodImageName: "happy", day: "19", month: "FEB", time: "10:00")
                .preferredColorScheme(.light)
        }
    }
}
