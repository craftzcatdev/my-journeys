//
//  String+Extensions.swift
//  Movies
//
//  Created by Hai Ng. on 15/3/26.
//

import Foundation

extension String {
    var isEmptyOrWhitespace: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
