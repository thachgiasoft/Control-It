//
//  MoodSheetViewModel.swift
//  Control It WatchKit Extension
//
//  Created by Leonardo Viana on 05/03/21.
//

import Foundation
import Combine

class MoodSheetViewModel: ObservableObject {
    @Published var moodWasChosen: Bool = false
}
