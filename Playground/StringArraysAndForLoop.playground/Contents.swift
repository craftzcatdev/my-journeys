import UIKit

//let listOfPeople = ["Smith", "John", "Smith", "Jane", "Robert","Doe"]
//
//for name in listOfPeople {
//    print("Name: \(name)")
//}
//
//
//let names: [String] = ["Smith", "John", "Smith", "Jane", "Robert","Doe"]
//
//for person in names {
//    print(person)
//}

// MARK: - TOPIC: More on loops (for, while, repeat)

/// i = -3,-2,-1,0,1,2,3
for i in -3...3 {
    print(i)
}

print("---")

/// i = -3,-2,-1,0,1,2,
for i in -3..<3 {
    print(i)
}

var sum = 0
var j = 0

while j < 10 {
    sum += j
    j += 1
}

print("The sum 0 + 1 + ... + 9 is \(sum)")

func sumExample(n: Int) -> Int {
    var sum = 0
    var j = 0

    while j < n {
        sum += j
        j += 1
    }
    
    return sum
}

for n in 10..<20 {
    print("The sum 0 + ... + \(n) is \(sumExample(n: n))")
}

/// Repeat loops - less common
/// Do at least once.
/// In other languages it is usually
/// called do-while loop

/// Code to display some numbers

var i = 1
let n = 10

repeat {
    print(i)
    i = i + 1
} while (i <= n)
