//
//  Item.swift
//  HP Trivia
//
//  Created by yaxin on 2025-03-08.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
