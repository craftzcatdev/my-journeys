//
//  Vegetable.swift
//  GardenGreens
//
//  Created by Mohammad Azam on 9/28/23.
//

import Foundation
import SwiftData

@Model
class Vegetable {
    
    var name: String = ""
    @Relationship(deleteRule: .cascade) var notes: [Note]?
    
    init(name: String) {
        self.name = name
    }
}
