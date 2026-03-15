# 🎬 Movies App

A simple iOS app built while learning **SwiftData** from the course  
[SwiftData: Declarative Data Persistence for SwiftUI](https://www.udemy.com/course/swiftdata-declarative-data-persistence-for-swiftui/) by **AzamSharp** on Udemy.

---

## 📌 What I Learned

- Setting up `ModelContainer` in the App entry point
- Creating a `@Model` class with SwiftData
- Using `@Environment(\.modelContext)` to insert and save data
- Using `@Query` to fetch and display persisted data
- Form validation with computed `isFormValid` property
- Presenting a sheet for adding new entries
- `context.save()` with `do/catch` error handling

---

## 🛠️ Tech Stack

| | |
|---|---|
| **Language** | Swift 6 |
| **UI** | SwiftUI |
| **Persistence** | SwiftData |
| **Min Target** | iOS 17+ |

---

## 📁 Project Structure

```
Movies/
├── MoviesApp.swift          # App entry — ModelContainer setup
├── ContentView.swift        # Root view
├── Models/
│   └── Movie.swift          # @Model — title, year
├── Screens/
│   └── AddMovieScreen.swift # Form to add new movie
└── Extensions/
    └── String+Extensions.swift
```

---

## 🧠 Key Code Snippets

### `@Model` Declaration
```swift
@Model
final class Movie {
    var title: String
    var year: Int

    init(title: String, year: Int) {
        self.title = title
        self.year = year
    }
}
```

### Insert & Save via `modelContext`
```swift
@Environment(\.modelContext) private var context

let movie = Movie(title: title, year: year)
context.insert(movie)

do {
    try context.save()
} catch {
    print(error.localizedDescription)
}
```

### Form Validation
```swift
private var isFormValid: Bool {
    !title.isEmptyOrWhitespace && year != nil
}
```

---

## 📈 Progress

- [x] Setup SwiftData `ModelContainer`
- [x] Create `@Model` class — `Movie`
- [x] Add movie via Form sheet
- [x] Save to SwiftData with error handling
- [ ] Display list of movies with `@Query`
- [ ] Delete movie with swipe action
- [ ] Edit existing movie
- [ ] Filter & sort with `#Predicate`
