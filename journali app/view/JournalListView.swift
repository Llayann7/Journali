import SwiftUI

struct JournalListView: View {
    private let journals = Journal.samples
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            List(journals) { journal in
                JournalRowView(journal: journal)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Theme.background.ignoresSafeArea())
            .navigationTitle("Journal")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 16) {
                        Menu {
                            Button("Sort by Bookmark") { }
                            Button("Sort by Entry Date") { }
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                        }

                        Button { } label: {
                            Image(systemName: "plus")
                        }
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Theme.card)
                    .clipShape(Capsule())
                }
            }
            .safeAreaInset(edge: .bottom) {
                searchBar
            }
        }
        .preferredColorScheme(.dark)
    }

    private var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField("Search", text: $searchText)
                .foregroundColor(.white)

            Image(systemName: "mic.fill")
                .foregroundColor(.gray)
        }
        .padding(12)
        .background(Theme.card)
        .clipShape(Capsule())
        .padding(.horizontal, 16)
        .padding(.bottom, 4)
    }
}

// MARK: - One card

struct JournalRowView: View {
    let journal: Journal

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(journal.title)
                    .font(.headline)
                    .foregroundColor(Theme.accent)

                Spacer()

                Image(systemName: journal.isBookmarked ? "bookmark.fill" : "bookmark")
                    .foregroundColor(Theme.accent)
            }

            Text(journal.date)
                .font(.caption)
                .foregroundColor(.gray)

            Text(journal.content)
                .font(.subheadline)
                .foregroundColor(.white)
                .lineLimit(5)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.card)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    JournalListView()
}

