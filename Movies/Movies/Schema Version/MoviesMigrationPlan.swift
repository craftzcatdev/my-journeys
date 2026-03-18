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
        [MovieSchemaV1.self, MovieSchemaV2.self, MovieSchemaV3.self]
    }
    
    static var stages: [MigrationStage] {
        [migrateV1ToV2, migrateV2ToV3]
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
                if !uniqueSet.insert(movie.name).inserted {
                    duplicates.insert(movie)
                }
            }
            
            for movie in duplicates {
                guard let movieToBeUpdated = movies.first(where: {$0.id == movie.id }) else {
                    continue
                }
                movieToBeUpdated.name = movieToBeUpdated.name + " \(UUID().uuidString)"
            }
            
            try? context.save()
        },
        didMigrate: nil)
    
    static let migrateV2ToV3 = MigrationStage.lightweight(fromVersion: MovieSchemaV2.self, toVersion: MovieSchemaV3.self)
}
