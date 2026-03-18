//
//  MoviesMigrationPlan.swift
//  Movies
//
//  Created by Hai Ng. on 18/3/26.
//

import Foundation
import SwiftData

enum MoviesMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [MovieSchemaV1.self, MovieSchemaV2.self]
    }
    
    static var stages: [MigrationStage] {
        [migrateV1ToV2]
    }
    
    static let migrateV1ToV2 = MigrationStage.custom(
        fromVersion: MovieSchemaV1.self,
        toVersion: MovieSchemaV2.self,
        willMigrate: { context in
            
            guard let movies = try? context.fetch(FetchDescriptor<Movie>()) else {
                return
            }
        
            var duplicates = Set<Movie>()
            var uniqueSet = Set<String>()
            
            for movie in movies {
                if !uniqueSet.insert(movie.title).inserted {
                    duplicates.insert(movie)
                }
            }
            
            for movie in duplicates {
                guard let movieToBeUpdated = movies.first(where: {$0.id == movie.id }) else {
                    continue
                }
                movieToBeUpdated.title = movieToBeUpdated.title + " \(UUID().uuidString)"
            }
            
            try? context.save()
        },
        didMigrate: nil)
}
