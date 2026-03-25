//
//  DefGhibliService.swift
//  Ghibli
//
//  Created by Hai Ng. on 24/3/26.
//

import Foundation

struct DefGhibliService: GhibliService {
    /// `<T: Decodable>` nghĩa là "T có thể là bất kỳ type nào, miễn là Decodable".
    func fetch<T: Decodable>(from URLString: String, type: T.Type) async throws -> T {
        guard let url: URL = URL(string: URLString) else {
            throw APIError.invalidUrl
        }
            
        do {
            let (data, reponse) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = reponse as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            
           return try JSONDecoder().decode(type.self, from: data)
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
    }
    
    func fetchFilms() async throws -> [Film] {
        
        let url = "https://ghibliapi.vercel.app/films"
        return try await fetch(from: url, type: [Film].self)
    }
    
    func fetchPeople(from URLString: String) async throws -> Person {
        try await fetch(from: URLString, type: Person.self)
    }
}
