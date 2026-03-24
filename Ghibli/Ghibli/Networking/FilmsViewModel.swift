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
    
    var errorDescription: String? {
        switch self {
            case .invalidUrl: return "The URL is Invalid"
            case .invalidResponse: return "Invalid Response from Server"
            case .decoding(let error): return "Fieled to decode response: \(error.localizedDescription)"
            case .networkError(let error): return "Network Error: \(error.localizedDescription)"
        }
    }
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
    
    private let service: GhibliService
    
    init(service: GhibliService = DefGhibliService()) {
        self.service = service
    }
    
    func fetch() async {
        
        guard state == .idle else { return }
        
        state = .loading
        
        do {
            let films = try await service.fetchFilms()
            self.state = .loaded(films)
        } catch let error as APIError {
            self.state = .error(error.errorDescription ?? "Unknown Error")
        } catch {
            self.state = .error("unknown error")
        }
    }
}
