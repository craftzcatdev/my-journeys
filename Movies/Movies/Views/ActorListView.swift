//
//  ActorListView.swift
//  Movies
//
//  Created by Hai Ng. on 16/3/26.
//

import SwiftUI

struct ActorListView: View {
    
    let actors: [Actor]
    
    var body: some View {
        List(actors) {actor in
            NavigationLink(value: actor) {
                ActorCellView(actor: actor)
            }
        }
        .navigationDestination(for: Actor.self) { actor in
            ActorDetailScreen(actor: actor)
        }
    }
}

#Preview {
    ActorListView(actors: [])
}
