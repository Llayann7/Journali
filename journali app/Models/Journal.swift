import Foundation
import SwiftData

@Model
final class Journal {
    var title: String
    var content: String
    var date: Date
    var isBookmarked: Bool

    init(title: String, content: String, date: Date = .now, isBookmarked: Bool = false) {
        self.title = title
        self.content = content
        self.date = date
        self.isBookmarked = isBookmarked
    }
}

extension Journal {
    /// جورنال تجريبي للـ Preview بس
    static var sample: Journal {
        Journal(
            title: "My Birthday",
            content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis. Suspendisse urna nibh viverra non",
            isBookmarked: true
        )
    }
}
