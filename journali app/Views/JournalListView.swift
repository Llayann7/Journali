import SwiftUI
import SwiftData

struct JournalListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var journals: [Journal]
    @State private var viewModel = JournalViewModel()

    @State private var searchText = ""
    @State private var isShowingAddSheet = false
    @State private var journalToEdit: Journal?
    @State private var journalToDelete: Journal?
    @State private var isShowingDeleteAlert = false

    private var visibleJournals: [Journal] {
        viewModel.visibleJournals(from: journals, searchText: searchText)
    }

    var body: some View {
        NavigationStack {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Theme.background.ignoresSafeArea())
                .navigationTitle("Journal")
                .toolbar { toolbarContent }
                .searchable(text: $searchText)
                .sheet(isPresented: $isShowingAddSheet) {
                    JournalEditorView { title, content in
                        viewModel.addJournal(title: title, content: content, context: modelContext)
                    }
                }
                .sheet(item: $journalToEdit) { journal in
                    JournalEditorView(journal: journal) { title, content in
                        viewModel.updateJournal(journal, title: title, content: content)
                    }
                }
                .alert("Delete Journal?",
                       isPresented: $isShowingDeleteAlert,
                       presenting: journalToDelete) { journal in
                    Button("Cancel", role: .cancel) { }
                    Button("Delete", role: .destructive) {
                        viewModel.deleteJournal(journal, context: modelContext)
                    }
                } message: { _ in
                    Text("Are you sure you want to delete this journal?")
                }
        }
    }

    // MARK: - المحتوى

    @ViewBuilder
    private var content: some View {
        if journals.isEmpty {
            EmptyStateView()
        } else if visibleJournals.isEmpty {
            if searchText.isEmpty {
                // فلتر البوكمارك شغال وما فيه ولا جورنال محفوظ
                ContentUnavailableView(
                    "No Bookmarks",
                    systemImage: "bookmark",
                    description: Text("Tap the bookmark icon on a journal to find it here.")
                )
            } else {
                ContentUnavailableView.search(text: searchText)
            }
        } else {
            journalList
        }
    }

    private var journalList: some View {
        List(visibleJournals) { journal in
            JournalRowView(journal: journal) {
                viewModel.toggleBookmark(journal)
            }
            .contentShape(.rect)
            .onTapGesture {
                journalToEdit = journal
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            // Swipe يمين للحذف
            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                Button {
                    requestDelete(journal)
                } label: {
                    Image(systemName: "trash.fill")
                }
                .tint(Theme.destructive)
            }
            // للآيباد والماك: كليك يمين / ضغطة مطوّلة
            .contextMenu {
                Button {
                    viewModel.toggleBookmark(journal)
                } label: {
                    Label(
                        journal.isBookmarked ? "Remove Bookmark" : "Bookmark",
                        systemImage: journal.isBookmarked ? "bookmark.slash" : "bookmark"
                    )
                }

                Button(role: .destructive) {
                    requestDelete(journal)
                } label: {
                    Label("Delete", systemImage: "trash.fill")
                }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }

    private func requestDelete(_ journal: Journal) {
        journalToDelete = journal
        isShowingDeleteAlert = true
    }

    // MARK: - التول بار (Native)

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItemGroup(placement: .primaryAction) {
            Menu {
                Picker("Sort", selection: $viewModel.sortOption) {
                    Text("Sort by Bookmark").tag(SortOption.bookmark)
                    Text("Sort by Entry Date").tag(SortOption.entryDate)
                }
                .pickerStyle(.inline)
            } label: {
                Label("Sort", systemImage: "line.3.horizontal.decrease")
            }

            Button {
                isShowingAddSheet = true
            } label: {
                Label("Add Journal", systemImage: "plus")
            }
        }
    }
}

// MARK: - الكرت الواحد

struct JournalRowView: View {
    let journal: Journal
    let onBookmark: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(journal.title)
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(Theme.accent)

                Spacer()

                Button(action: onBookmark) {
                    Image(systemName: journal.isBookmarked ? "bookmark.fill" : "bookmark")
                        .font(.title3)
                        .foregroundStyle(Theme.accent)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(journal.isBookmarked ? "Remove Bookmark" : "Bookmark")
            }

            Text(journal.date.journalFormatted)
                .font(.caption)
                .foregroundStyle(Theme.secondaryText)

            Text(journal.content)
                .font(.body)
                .foregroundStyle(Theme.primaryText)
                .lineLimit(5)
                .padding(.top, 4)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.card, in: .rect(cornerRadius: 20))
    }
}

#Preview {
    JournalListView()
        .modelContainer(for: Journal.self, inMemory: true)
        .preferredColorScheme(.dark)
}
