import UIKit

/// Is it really true that everybody likes to skateboard?
/// Perhaps we should consider people and thier is hoppies.
/// Introduce `struct`

struct PersonWithHobbies {
    let name: String
    let hobbies: String
}

let person: [PersonWithHobbies] = [
    PersonWithHobbies(name: "Ron", hobbies: "skateboard"),
    PersonWithHobbies(name: "Elmon", hobbies: "Badminton"),
    PersonWithHobbies(name: "John", hobbies: "Tenis")
]

for p in person {
    print("\(p.name) likes \(p.hobbies)")
}

/// Options
/// [1,2,10,50,7,-3]

var x: Int = 7
var y: Int? = 10

x = 12345
y = 12345
y = -12345
y = nil


/// Bilion dollar error


