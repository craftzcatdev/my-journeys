//
//  Room.swift
//  Room
//
//  Created by Hai Ng. on 19/3/26.
//

import Foundation
import SwiftData
import UIKit

@Model
class Room {
    var name: String
    @Attribute(.transformable(by: UIColorValueTransformer.transformerName.rawValue))
    var color: UIColor

    init(name: String, color: UIColor) {
        self.name = name
        self.color = color
    }
}

