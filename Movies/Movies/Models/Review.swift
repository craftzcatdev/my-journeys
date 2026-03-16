//
//  Review.swift
//  Movies
//
//  Created by Hai Ng. on 16/3/26.
//

import Foundation
import SwiftData

@Model
final class Review {
    var subject: String
    var body: String
    var movie: Movie?
    
    init(subject: String, body: String) {
        self.subject = subject
        self.body = body
    }
}
