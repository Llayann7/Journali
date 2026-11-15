import SwiftUI

struct JournalEditorView: View {
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isTitleFocused: Bool
    @State private var title: String
    @State private var content: String
    @State private var isShowingDiscardAlert = false

    let journal: Journal?
    let onSave: (String, String) -> Void

    init(journal: Journal? = nil, onSave: @escaping (String, String) -> Void) {
        self.journal = journal
        self.onSave = onSave
        _title = State(initialValue: journal?.title ?? "")
        _content = State(initialValue: journal?.content ?? "")
    }

    private var isEditing: Bool {
        journal != nil
    }

    // هل المستخدم كتب أو غيّر شي ما انحفظ؟
    private var hasChanges: Bool {
        title != (journal?.title ?? "") || content != (journal?.content ?? "")
    }

    // العنوان والمحتوى فاضيين أو مسافات بس
    private var isBlank: Bool {
        title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                TextField("Title", text: $title)
                    .font(.largeTitle.bold())
                    .focused($isTitleFocused)

                Text((journal?.date ?? .now).journalFormatted)
                    .font(.caption)
                    .foregroundStyle(Theme.secondaryText)

                ZStack(alignment: .topLeading) {
                    TextEditor(text: $content)
                        .scrollContentBackground(.hidden)
                        .scrollDismissesKeyboard(.interactively)

                    if content.isEmpty {
                        Text("Type your Journal...")
                            .foregroundStyle(.secondary)
                            .padding(.top, 8)
                            .padding(.leading, 5)
                            .allowsHitTesting(false)
                    }
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .toolbar { toolbarContent }
            .alert(
                "Are you sure you want to discard changes on this journal?",
                isPresented: $isShowingDiscardAlert
            ) {
                Button("Discard Changes", role: .destructive) {
                    dismiss()
                }
                Button("Keep Editing", role: .cancel) { }
            }
            .task {
                // بالإضافة بس: يفتح الكيبورد على العنوان مباشرة
                if !isEditing {
                    isTitleFocused = true
                }
            }
        }
        // يمنع إغلاق الشاشة بالسحب وفيها شي ما انحفظ
        .interactiveDismissDisabled(hasChanges)
    }

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .cancellationAction) {
            Button {
                if hasChanges {
                    isShowingDiscardAlert = true
                } else {
                    dismiss()
                }
            } label: {
                Image(systemName: "xmark")
            }
        }

        ToolbarItem(placement: .confirmationAction) {
            Button {
                onSave(
                    title.trimmingCharacters(in: .whitespacesAndNewlines),
                    content.trimmingCharacters(in: .whitespacesAndNewlines)
                )
                dismiss()
            } label: {
                Image(systemName: "checkmark")
            }
            .buttonStyle(.borderedProminent)
            .tint(Theme.primaryAccent)
            // ما ينحفظ جورنال فاضي (عنوان ومحتوى كلهم فاضيين)
            .disabled(isBlank)
        }
    }
}

#Preview("Add") {
    JournalEditorView { _, _ in }
}

#Preview("Edit") {
    JournalEditorView(journal: Journal.sample) { _, _ in }
}
