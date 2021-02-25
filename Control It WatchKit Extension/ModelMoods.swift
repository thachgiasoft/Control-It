//
//  ModelMoods.swift
//  Control It WatchKit Extension
//
//  Created by Ingra Cristina on 25/02/21.
//

import SwiftUI

struct ModelMoods: Identifiable {
    var id: UUID
    var moods: [ListMoods]
}
struct ListMoods {
    var id: UUID
    var name: String
    var mainImage: String {
        name.replacingOccurrences(of: " ", with: "-").lowercased()
    }
    var thumbnailImage: String {
        "\(mainImage)-thumb"
    }
    
}

