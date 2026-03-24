//
//  FilmsViewModel.swift
//  Ghibli
//
//  Created by Hai Ng. on 24/3/26.
//

import Foundation
import Observation

@Observable
class FilmsViewModel {
    
    var films: [Film] = []
    
    func fetchFilms() async {
        let url: URL = URL(string: "https://ghibliapi.vercel.app/films")!
            
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            films = try JSONDecoder().decode([Film].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
}
