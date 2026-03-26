import UIKit

/// variables are mutable
/// let constants are imutable
var greeting = "Hello, playground"
var likeHuman = "Like Human"

print(greeting)

greeting = "Like Human"

print(greeting)

greeting = "Ron is " + greeting

print(greeting)

var name = "Jane"
greeting = name + " " + likeHuman

print(greeting)
