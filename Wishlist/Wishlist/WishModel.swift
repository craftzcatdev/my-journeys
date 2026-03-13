//
//  WishModel.swift
//  Wishlist
//
//  Created by Hai Ng. on 13/3/26.
//

import Foundation
import SwiftData

@Model
class Wish {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}
