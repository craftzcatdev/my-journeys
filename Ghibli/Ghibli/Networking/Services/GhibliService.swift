//
//  GhibliService.swift
//  Ghibli
//
//  Created by Hai Ng. on 24/3/26.
//

import Foundation

protocol GhibliService: Sendable {
    func fetchFilms() async throws -> [Film]
    func fetchPeople(from URLString: String) async throws -> Person
}
