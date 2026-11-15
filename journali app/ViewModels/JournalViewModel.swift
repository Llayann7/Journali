import SwiftUI
import SwiftData

enum SortOption {
    case entryDate
    case bookmark
}

@Observable
final class JournalViewModel {
    var sortOption: SortOption = .entryDate


    func addJournal(title: String, content: String, context: ModelContext) {
        context.insert(Journal(title: title, content: content))
    }

    func updateJournal(_ journal: Journal, title: String, content: String) {
        journal.title = title
        journal.content = content
    }

    func deleteJournal(_ journal: Journal, context: ModelContext) {
        context.delete(journal)
    }


    func toggleBookmark(_ journal: Journal) {
        journal.isBookmarked.toggle()
    }


    func visibleJournals(from journals: [Journal], searchText: String) -> [Journal] {
        let matches = searchText.isEmpty ? journals : journals.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.content.localizedCaseInsensitiveContains(searchText)
        }

        let newestFirst = matches.sorted { $0.date > $1.date }

        switch sortOption {
        case .entryDate:
            return newestFirst
        case .bookmark:
            return newestFirst.filter { $0.isBookmarked }
        }
    }
}
