//
//  APIError.swift
//  Ghibli
//
//  Created by Hai Ng. on 25/3/26.
//
import Foundation

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
