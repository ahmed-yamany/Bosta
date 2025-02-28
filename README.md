
# 📦 Bosta iOS Task

This is a sample iOS project developed for the **Bosta iOS Assessment Task**.  
The app displays a **user profile screen** with the user's information at the top, followed by a list of albums.  
Tapping an album navigates to a photo gallery screen.

---

## 🏛️ Architecture

The project follows **MVVM with Clean Architecture**, with clear separation of:

- **Domain Layer:** Business logic, use cases, and entities.
- **Data Layer:** Networking using **Moya**.
- **Presentation Layer:** ViewModels, Views, and Coordinators.

The project is also enhanced with:

- **Combine** for reactive data handling.
- **Moya** for networking and API abstraction.
- **UITableView/UICollectionView Section Strategies** using the **Strategy Design Pattern**.
- **Coordinators** for navigation flow management.
- **Unit Tests** for key ViewModels to validate their behavior and ensure reliability.

This ensures the code is **modular**, **testable**, and **easily extensible**.

---

## ✨ Features

- User profile display (name and address).
- List of user albums.
- Tap album to view album photos.
- Photo grid with compositional layout.
- Modular **section-based architecture** for both table and collection views.
- Safe collection access via `Collection[safe:]` extension.
- Type-safe cell registration and dequeuing helpers.
- Unit tests for `ProfileViewModel` to ensure proper data flow and section handling.

---

## 📂 Project Structure

```
📂 Sources
├── 📂 Modules
│   ├── User Profile
│   │   ├── View
│   │   ├── ViewModel
│   │   ├── Sections (TableViewSection implementations)
│   │   └── Coordinator
│   ├── Album Details
│   │   ├── View
│   │   ├── ViewModel
│   │   ├── Sections (CollectionViewSection implementations)
│   │   └── Coordinator
├── 📂 Tests
│   ├── ProfileViewModelTests.swift
```

---

## 🛠️ Technologies & Dependencies

| Dependency           | Purpose                                  |
|---------------------|----------------------------------|
| Swift 5.5+            | Programming language               |
| UIKit                    | UI Framework                             |
| Combine               | Reactive bindings                      |
| Moya                    | Network layer                           |
| Swift Package Manager | Dependency management      |
| XCTest                  | Unit Testing Framework            |

---

## ⚙️ Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/ahmed-yamany/Bosta.git
    ```
2. Open the project in **Xcode**.
3. Ensure all dependencies are fetched via **Swift Package Manager**.
4. Run the project on the simulator.

---

## 📊 Architecture Breakdown

### TableView Sections

The app uses a **Strategy Pattern** for managing `UITableView` sections.  
Each section is a separate class conforming to `TableViewSection`, responsible for:

- Registering cells.
- Providing data (number of rows and cell configuration).
- Handling user interactions (row selection).

This allows sections to be **modular and easily composable**.

#### Example

```swift
let userDetailsSection = UserDetailsSection(user: userEntity)
let albumsSection = AlbumsTableViewSection(albums: albums) { selectedAlbum in
    // Handle album selection
}

sections = [userDetailsSection, albumsSection]
```

---

### CollectionView Sections

Similarly, album photos are displayed using **CollectionViewSection**, which follows the same **Strategy Pattern**, adapted for compositional layouts.

Each section:

- Registers cells.
- Defines items and groups.
- Provides a full compositional layout section.

---

## 🔗 API Endpoints

The project integrates with [JSONPlaceholder](https://jsonplaceholder.typicode.com) API:

- **Users:** `/users` - Fetch user information.
- **Albums:** `/albums?userId={id}` - Fetch albums for a specific user.
- **Photos:** `/photos?albumId={id}` - Fetch photos for a specific album.

---

## ✅ Code Highlights

### Safe Collection Access

```swift
let photo = photos[safe: indexPath.item]
```
This prevents out-of-bounds crashes.

### Type-safe Cell Registration & Dequeuing

```swift
collectionView.registerFromNib(PhotoCell.self)
let cell = collectionView.dequeueReusableCell(PhotoCell.self, for: indexPath)
```

- No hardcoded identifiers.
- Reduces boilerplate.
- Fully type-safe.

---

## 🧪 Unit Tests

Unit tests are included to ensure the correctness of core components, particularly the **ProfileViewModel**.

### Current Tests

- ✅ `ProfileViewModelTests`: Validates:
    - Successful fetching updates sections correctly.
    - Album selection triggers correct navigation via `ProfileCoordinator`.

Unit tests can be found in the `Tests` directory.

---

## 🤝 Contribution

Contributions are welcome! Feel free to fork and submit a pull request if you want to improve this project.

---

## 👤 Author

Developed by [Ahmed Yamany] - [https://www.linkedin.com/in/ahmed-yamany/]
