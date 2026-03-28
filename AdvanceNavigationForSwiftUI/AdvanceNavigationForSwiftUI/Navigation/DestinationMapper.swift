//
//  DestinationMapper.swift
//  AdvanceNavigationForSwiftUI
//
//  Created by Hai Ng. on 28/3/26.
//

import SwiftUI

// Pure function: Destination → View
// Tất cả mapping tập trung ở đây, không phân tán trong các View
struct DestinationMapper {
    
    @ViewBuilder
    static func view(for push: Destination.Push) -> some View {
        switch push {
        case .movieDetail(let movie):
            MovieDetailView(movie: movie)
        case .actorDetail(let actorID, let actorName):
            ActorDetailView(actorID: actorID, actorName: actorName)
        }
    }
    
    @ViewBuilder
    static func view(for sheet: Destination.Sheet) -> some View {
        switch sheet {
        case .movieFilter:
            Label("Filter Screen", systemImage: "slider.horizontal.3")
                .font(.title)
                .padding()
        case .addToFavorite(let movie):
            Label("Added \(movie.title) to Favorites!", systemImage: "heart.fill")
                .foregroundStyle(.pink)
                .font(.title2)
                .padding()
        }
    }
    
    @ViewBuilder
    static func view(for fullScreen: Destination.FullScreen) -> some View {
        switch fullScreen {
        case .moviePlayer(let movieID):
            ZStack {
                Color.black.ignoresSafeArea()
                Label("Playing Movie ID: \(movieID)", systemImage: "play.fill")
                    .foregroundColor(.white)
                    .font(.title)
            }
        }
    }
}
