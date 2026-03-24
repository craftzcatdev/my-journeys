//
//  FilmsViewModel.swift
//  Ghibli
//
//  Created by Hai Ng. on 24/3/26.
//

import Foundation
import Observation

enum APIError: LocalizedError {
    case invalidUrl
    case invalidResponse
    case decoding(Error)
    case networkError(Error)
}

@Observable
class FilmsViewModel {
    
    enum State: Equatable {
        case idle
        case loading
        case loaded([Film])
        case error(String)
    }
    
    var state: State = .idle
    var films: [Film] = []
    
    func fetch() async {
        
        guard state == .idle else { return }
        
        state = .loading
        
        do {
            let films = try await fetchFilms()
            self.state = .loaded(films)
        } catch {
            self.state = .error(error.localizedDescription)
        }
    }
    
    private func fetchFilms() async throws -> [Film] {
        guard let url: URL = URL(string: "https://ghibliapi.vercel.app/films") else {
            throw APIError.invalidUrl
        }
            
        do {
            let (data, reponse) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = reponse as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            
           return try JSONDecoder().decode([Film].self, from: data)
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
    }
}
