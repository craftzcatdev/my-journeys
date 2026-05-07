//
//  Furniture.swift
//  StoringImages
//
//  Created by Mohammad Azam on 11/30/23.
//

import Foundation
import SwiftData

@Model
class Furniture {
    
    // we will take a look at attributes later 
    var photo: Data?
    
    init(photo: Data? = nil) {
        self.photo = photo
    }
    
}
