//
//  Recording.swift
//  Control It WatchKit Extension
//
//  Created by Leonardo Viana on 25/02/21.
//

import Foundation

struct Recording: Hashable {
    let fileURL: URL
    let createdAt: Date
}

let fakeRecords: [Recording] = [
    .init(fileURL: URL.init(fileURLWithPath: ".../"), createdAt: Date.distantFuture),
    .init(fileURL: URL.init(fileURLWithPath: ".../"), createdAt: Date.distantFuture),
    .init(fileURL: URL.init(fileURLWithPath: ".../"), createdAt: Date.distantFuture),
    .init(fileURL: URL.init(fileURLWithPath: ".../"), createdAt: Date.distantFuture),
]
