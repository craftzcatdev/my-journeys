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
            Text(actor.name)
        }
    }
}

#Preview {
    ActorListView(actors: [])
}
