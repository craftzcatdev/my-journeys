//
//  HomeView.swift
//  AdvanceNavigationForSwiftUI
//
//  Created by Hai Ng. on 28/3/26.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(\.router) private var router
    
    var body: some View {
        List(Movie.samples) { movie in
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(movie.title)
                        .font(.headline)
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundStyle(.yellow)
                        Text("\(movie.rating, specifier: "%.1f")")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }
                Spacer()
                // Dùng NavigationButton thay vì NavigationLink
                NavigationButton(push: .movieDetail(movie: movie)) {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.blue)
                }
            }
            .padding(.vertical, 4)
        }
        .navigationTitle("Movies")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                // Sheet từ toolbar
                NavigationButton(sheet: .movieFilter) {
                    Image(systemName: "slider.horizontal.3")
                }
            }
        }
    }
}

