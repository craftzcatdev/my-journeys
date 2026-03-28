//
//  Router.swift
//  AdvanceNavigationForSwiftUI
//
//  Created by Hai Ng. on 28/3/26.
//

import SwiftUI

@Observable
class Router {
    
    // State cho Push navigation (NavigationStack path)
    var pushPath: [Destination.Push] = []
    
    // State cho Sheet
    var activeSheet: Destination.Sheet? = nil
    
    // State cho Full Screen
    var activeFullScreen: Destination.FullScreen? = nil
    
    // Quan hệ parent-child để bubble up deep link
    weak var parent: Router?
    
    // Tab selection (nếu dùng ở root)
    var selectedTab: Int = 0
    
    // MARK: - Navigation Actions
    
    func push(_ destination: Destination.Push) {
        pushPath.append(destination)
    }
    
    func pop() {
        guard !pushPath.isEmpty else { return }
        pushPath.removeLast()
    }
    
    func popToRoot() {
        pushPath.removeAll()
    }
    
    func presentSheet(_ destination: Destination.Sheet) {
        activeSheet = destination
    }
    
    func dismissSheet() {
        activeSheet = nil
    }
    
    func presentFullScreen(_ destination: Destination.FullScreen) {
        activeFullScreen = destination
    }
    
    func dismissFullScreen() {
        activeFullScreen = nil
    }
    
    // MARK: - Deep Link Handler
    // Pure function: URL string → Destination.Push (dễ unit test)
    static func destination(fromDeepLink path: String) -> Destination.Push? {
        // Ví dụ URL: movieapp://movie/tt1234
        //            movieapp://actor/nm5678/Tom%20Hanks
        let components = path
            .trimmingCharacters(in: .init(charactersIn: "/"))
            .split(separator: "/")
            .map(String.init)
        
        guard let first = components.first else { return nil }
        
        switch first {
        case "movie":
            guard let movieID = components[safe: 1] else { return nil }
            let movie = Movie(id: movieID, title: "Movie \(movieID)", rating: 8.0)
            return .movieDetail(movie: movie)
            
        case "actor":
            guard let actorID = components[safe: 1],
                  let rawName = components[safe: 2] else { return nil }
            let actorName = rawName.replacingOccurrences(of: "%20", with: " ")
            return .actorDetail(actorID: actorID, actorName: actorName)
            
        default:
            return nil
        }
    }
}

// Helper để safe array subscript
extension Array {
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < count else { return nil }
        return self[index]
    }
}

