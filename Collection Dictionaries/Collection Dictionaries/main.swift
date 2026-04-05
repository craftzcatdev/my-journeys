//
//  main.swift
//  Collection Dictionaries
//
//  Created by Hai Ng. on 4/4/26.
//

import Foundation

print("Dictionaries")

//var foodDictionary: [String: Int] = [:]
//
//foodDictionary["apple"] = 3
//foodDictionary["banana"] = 4
//foodDictionary["orange"] = 1

var foodCaterories: [String: Int] = ["banana": 105, "apple": 208, "orange": 95, "salad": 100]
print(foodCaterories)

if let cateires = foodCaterories["cake"] {
    print(cateires)
} else {
    foodCaterories["cake"] = 250
    print("We do not have information about this food")
}

print(foodCaterories)

let calories: Int = foodCaterories["banana", default: 0]

