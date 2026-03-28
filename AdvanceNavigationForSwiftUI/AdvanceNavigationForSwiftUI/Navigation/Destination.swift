//
//  Destination.swift
//  AdvanceNavigationForSwiftUI
//
//  Created by Hai Ng. on 28/3/26.
//

import Foundation

// Trung tâm hóa tất cả điểm đến trong app
enum Destination: Hashable {
    
    // PUSH destinations (NavigationStack push)
    enum Push: Hashable {
        case movieDetail(movie: Movie)
        case actorDetail(actorID: String, actorName: String)
    }
    
    // SHEET destinations (modal bottom sheet)
    enum Sheet: Identifiable, Hashable {
        case movieFilter
        case addToFavorite(movie: Movie)
        
        var id: String {
            switch self {
            case .movieFilter:       return "movieFilter"
            case .addToFavorite(let m): return "addToFavorite_\(m.id)"
            }
        }
    }
    
    // FULL SCREEN destinations
    enum FullScreen: Identifiable, Hashable {
        case moviePlayer(movieID: String)
        
        var id: String {
            switch self {
            case .moviePlayer(let id): return "player_\(id)"
            }
        }
    }
}
