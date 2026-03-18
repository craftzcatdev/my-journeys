# 🎬 Movies App

A simple iOS app built while learning **SwiftData** from the course  
[SwiftData: Declarative Data Persistence for SwiftUI](https://www.udemy.com/course/swiftdata-declarative-data-persistence-for-swiftui/) by **AzamSharp** on Udemy.

> ✅ **Project completed!** All core SwiftData features have been implemented.

---

## 📌 What I Learned

- Setting up `ModelContainer` in the App entry point
- Creating a `@Model` class with SwiftData
- Using `@Environment(\.modelContext)` to insert and save data
- Using `@Query` to fetch and display persisted data
- Filtering and sorting data with `#Predicate` and `SortDescriptor`
- Swipe-to-delete with `modelContext.delete(_:)`
- Editing existing records via a dedicated edit screen
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
├── ContentView.swift        # Root view with movie list
├── Models/
│   └── Movie.swift          # @Model — title, year
├── Screens/
│   ├── AddMovieScreen.swift  # Form to add new movie
│   └── EditMovieScreen.swift # Form to edit existing movie
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

### Query with Sort
```swift
@Query(sort: \Movie.title, order: .forward)
private var movies: [Movie]
```

### Delete with Swipe Action
```swift
.onDelete { indexSet in
    indexSet.forEach { context.delete(movies[$0]) }
}
```

### Filter with `#Predicate`
```swift
let descriptor = FetchDescriptor<Movie>(
    predicate: #Predicate { $0.year >= 2000 },
    sortBy: [SortDescriptor(\.title)]
)
```

### Form Validation
```swift
private var isFormValid: Bool {
    !title.isEmptyOrWhitespace && year != nil
}
```

---

## ✅ Progress

- [x] Setup SwiftData `ModelContainer`
- [x] Create `@Model` class — `Movie`
- [x] Add movie via Form sheet
- [x] Save to SwiftData with error handling
- [x] Display list of movies with `@Query`
- [x] Delete movie with swipe action
- [x] Edit existing movie
- [x] Filter & sort with `#Predicate`
