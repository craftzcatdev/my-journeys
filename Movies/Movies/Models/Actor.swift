//
//  Actor.swift
//  Movies
//
//  Created by Hai Ng. on 16/3/26.
//

import Foundation
import SwiftData

@Model
final class Actor {
    
    var name: String
    var movies: [Movie] = []
    
    init(name: String) {
        self.name = name
    }
}
