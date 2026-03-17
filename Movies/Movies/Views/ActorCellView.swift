//
//  ActorCellView.swift
//  Movies
//
//  Created by Hai Ng. on 17/3/26.
//

import SwiftUI

struct ActorCellView: View {
    
    let actor: Actor
    
    var body: some View {
        VStack(alignment: .leading){
            Text(actor.name)
                .font(.title.weight(.medium))
            Text(actor.movies.map {$0.title}, format: .list(type: .and))
                .font(.caption)
        }
    }
}

//#Preview {
//    ActorCellView()
//}
