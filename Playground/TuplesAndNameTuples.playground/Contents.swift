import UIKit

/// Tuples
var addresses = ("John Doe", "123 main St", "Anytown", "USA", 23)

print(addresses)
print(addresses.0)
print(addresses.1)
print(addresses.2)
print(addresses.3)
print(addresses.4)

/// Named Tuples
var addresses2 = (
    name: "John Doe",
    streeet: "123 main St",
    city: "Anytown",
    country: "USA",
    age: 23
)

print("\(addresses2.name) is \(addresses2.age) years old and lives in \(addresses2.city), \(addresses2.country).")

