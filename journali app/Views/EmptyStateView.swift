import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack {
            // نفس صورة الكتاب اللي في التصميم
            Image("EmptyStateBook")
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal) { width, _ in
                    min(width * 0.35, 220)
                }
                .accessibilityHidden(true)

            Text("Begin Your Journal")
                .font(.title3.bold())
                .foregroundStyle(Theme.accent)

            Text("Craft your personal diary, tap the plus icon to begin")
                .font(.subheadline)
                .foregroundStyle(Theme.primaryText)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
    }
}

#Preview {
    EmptyStateView()
        .preferredColorScheme(.dark)
}
