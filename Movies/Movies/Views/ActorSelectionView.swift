//
//  ActorSelectionView.swift
//  Movies
//
//  Created by Hai Ng. on 17/3/26.
//

import SwiftUI
import SwiftData

struct ActorSelectionView: View {
    
    @Query(sort: \Actor.name, order: .forward) private var actors: [Actor]
    @Binding var selectedActors: Set<Actor>
    
    var body: some View {
        List(actors) {actor in
            HStack{
                Image(systemName: selectedActors.contains(actor) ? "checkmark.square.fill" : "square")
                    .onTapGesture {
                        if !selectedActors.contains(actor) {
                            selectedActors.insert(actor )
                        } else {
                            selectedActors.remove(actor)
                        }
                    }
                Text(actor.name)
            }
        }
        
    }
}

//#Preview {
//    ActorSelectionView()
//}
