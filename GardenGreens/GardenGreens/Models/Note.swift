//
//  Note.swift
//  GardenGreens
//
//  Created by Mohammad Azam on 9/28/23.
//

import Foundation
import SwiftData

@Model
class Note {
    
    var text: String = ""
    var vegetable: Vegetable? 
    
    init(text: String) {
        self.text = text
    }
}
