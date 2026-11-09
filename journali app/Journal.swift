import Foundation

struct Journal: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let content: String
    let isBookmarked: Bool
}

extension Journal {
    private static let sampleText = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis. Suspendisse urna nibh viverra non"

    static let samples: [Journal] = [
        Journal(title: "My Birthday", date: "02/09/2024", content: sampleText, isBookmarked: true),
        Journal(title: "Today’s Journal", date: "02/09/2024", content: sampleText, isBookmarked: false),
        Journal(title: "Great Day", date: "02/09/2024", content: sampleText, isBookmarked: false)
    ]
}
