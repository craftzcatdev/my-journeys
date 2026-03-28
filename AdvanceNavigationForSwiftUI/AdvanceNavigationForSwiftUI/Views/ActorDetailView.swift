//
//  ActorDetailView.swift
//  AdvanceNavigationForSwiftUI
//
//  Created by Hai Ng. on 28/3/26.
//

import SwiftUI

// ActorDetailView.swift
struct ActorDetailView: View {
    let actorID: String
    let actorName: String
    
    var body: some View {
        VStack(spacing: 20) {
            Circle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: 120, height: 120)
                .overlay(
                    Image(systemName: "person.fill")
                        .font(.system(size: 50))
                        .foregroundStyle(.gray)
                )
            
            Text(actorName).font(.title.bold())
            Text("Actor ID: \(actorID)").foregroundStyle(.secondary)
        }
        .navigationTitle(actorName)
    }
}

