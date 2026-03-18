//
//  MovieSchemaVersion.swift
//  Movies
//
//  Created by Hai Ng. on 18/3/26.
//

import Foundation
import SwiftData

enum MovieSchemaV1: VersionedSchema {
    static var versionIdentifier: Schema.Version {
        Schema.Version(1, 0, 0)
    }
    
    static var models: [any PersistentModel.Type]  {
        [Movie.self]
    }
    
    @Model
    final class Movie {
        var title: String
        var year: Int
        
        var reviewCount: Int {
            reviews.count
        }
        
        var actorCount: Int {
            actors.count
        }
        
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
}

enum MovieSchemaV2: VersionedSchema {
    static var versionIdentifier: Schema.Version {
        Schema.Version(2, 0, 0)
    }
    
    static var models: [any PersistentModel.Type]  {
        [Movie.self]
    }
    
    @Model
    final class Movie {
        @Attribute(.unique) var title: String
        var year: Int
        
        var reviewCount: Int {
            reviews.count
        }
        
        var actorCount: Int {
            actors.count
        }
        
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
}
