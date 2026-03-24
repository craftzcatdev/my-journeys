//
//  MockGhiBliService.swift
//  Ghibli
//
//  Created by Hai Ng. on 24/3/26.
//

import Foundation

struct MockGhiBliService: GhibliService {
    func fetchFilms() async throws -> [Film] {
        return []
    }
}
