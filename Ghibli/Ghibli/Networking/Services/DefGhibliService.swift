//
//  DefGhibliService.swift
//  Ghibli
//
//  Created by Hai Ng. on 24/3/26.
//

import Foundation

struct DefGhibliService: GhibliService {
    func fetchFilms() async throws -> [Film] {
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
