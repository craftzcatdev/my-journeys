//
//  Movie.swift
//  AdvanceNavigationForSwiftUI
//
//  Created by Hai Ng. on 28/3/26.
//

import Foundation

struct Movie: Hashable, Identifiable {
    let id: String
    let title: String
    let rating: Double
    
    static let samples: [Movie] = [
        Movie(id: "tt0111161", title: "The Shawshank Redemption", rating: 9.3),
        Movie(id: "tt0068646", title: "The Godfather", rating: 9.2),
        Movie(id: "tt0071562", title: "The Godfather Part II", rating: 9.0),
        Movie(id: "tt0468569", title: "The Dark Knight", rating: 9.0),
        Movie(id: "tt0050083", title: "12 Angry Men", rating: 9.0),
    ]
}

