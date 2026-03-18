//
//  Movie.swift
//  Movies
//
//  Created by Hai Ng. on 15/3/26.
//

import Foundation
import SwiftData

@Model
final class Movie {
    var title: String
    var year: Int
    
    @Relationship(deleteRule: .cascade, inverse: \Review.movie)
    var reviews: [Review] = []
    
    // FIX: Try to delete a Movie from an actor and add a new movie from the same actor
    // - To avoid the crash you can update the Movie model to have the @Relationship with actors to be .nullify instead of .noAction
    @Relationship(deleteRule: .nullify, inverse: \Actor.movies)
    var actors: [Actor] = []
    
    init(title: String, year: Int) {
        self.title = title
        self.year = year
    }
}
