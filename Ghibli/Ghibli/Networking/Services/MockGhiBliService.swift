//
//  MockGhiBliService.swift
//  Ghibli
//
//  Created by Hai Ng. on 24/3/26.
//

import Foundation

struct MockGhiBliService: GhibliService {
    
    private struct SampleData: Decodable {
        let films: [Film]
        let people: [Person]
    }
    
    private func loadSampleData() throws -> SampleData {
        guard let url = Bundle.main.url(forResource: "SampleData", withExtension: "json") else {
            throw APIError.invalidUrl
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(SampleData.self, from: data)
        } catch let error as DecodingError {
            throw APIError.decoding(error)
        } catch {
            throw APIError.networkError(error)
        }
    }
    
    func fetchFilms() async throws -> [Film] {
        
        let data = try loadSampleData()
        
        return data.films
    }
    
    func fetchPeople(from URLString: String) async throws -> Person {
        
        let data = try loadSampleData()
        
        return data.people.first!
    }
}
