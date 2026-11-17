# 📓 Journali

**Your thoughts, your story.**

Journali is a simple, private journaling app built with SwiftUI. Write down your thoughts and daily experiences, bookmark the entries that matter most, and find any memory in seconds with search and filters.

---

## ✨ Main Features

- **Create a journal** — tap **+** to write a new entry with a title and content. The date is added automatically.
- **Edit a journal** — tap any journal card to open it and update your thoughts.
- **Delete a journal** — swipe right on a card and confirm in the delete alert.
- **Bookmark entries** — tap the bookmark icon on a card to save your favorite or important journals.
- **Filter & sort** — use the filter menu to show only bookmarked journals or sort by entry date (newest first).
- **Search** — find journals by any word or phrase in the title or content.
- **Discard protection** — if you close the editor with unsaved changes, an alert asks whether to discard them or keep editing.
- **Empty state** — a friendly "Begin Your Journal" screen guides new users to their first entry.
- **Splash screen** — an animated launch screen with the Journali logo.
- **Saved on device** — journals are stored locally with SwiftData, so they're still there after you close the app.

## 🛠 Technologies Used

| | |
|---|---|
| **Language** | Swift |
| **UI** | SwiftUI |
| **Architecture** | MVVM (Model – View – ViewModel) |
| **Storage** | SwiftData |
| **State** | `@Observable`, `@State`, `@Query`, `@FocusState` |
| **Icons** | SF Symbols |
| **Design** | Dark mode, custom color sets, Liquid Glass native toolbar |

## 📂 Project Structure

```
journali app/
├── App/
│   └── MyApp.swift               # App entry point + splash transition
├── Models/
│   └── Journal.swift             # Journal data model (SwiftData)
├── ViewModels/
│   └── JournalViewModel.swift    # Add, edit, delete, bookmark, search & sort logic
├── Views/
│   ├── SplashView.swift          # Launch screen
│   ├── JournalListView.swift     # Main page: list, search, filter, swipe to delete
│   ├── JournalEditorView.swift   # Add / edit a journal
│   └── EmptyStateView.swift      # Shown when there are no journals yet
└── Utilities/
    ├── Theme.swift               # Design colors
    └── Date+Formatting.swift     # dd/MM/yyyy date format
```

## 🎨 Design

| Color | Hex | Used for |
|---|---|---|
| Primary / Accent | `#7F81FF` | Save button, active actions |
| Text / Accent | `#AF99FD` | Journal titles, empty-state heading |
| Text / Primary | `#FFFFFF` | Main headings, journal content |
| Text / Secondary | `#A39A9A` | Entry dates |
| Surface / Card | `#1C1C1E` | Journal cards |
| Background | `#000000` | Main screen background |
| Destructive | `#FD453C` | Delete action |

Font: **SF Pro** · Icons: **SF Symbols** (`plus`, `bookmark`, `bookmark.fill`, `trash.fill`, `xmark`, `checkmark`, `line.3.horizontal.decrease`)

## 🚀 How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/Llayann7/Journali.git
   ```
2. Open `journali app.xcodeproj` in Xcode.
3. Choose an iPhone simulator and press **Run** (⌘R).
