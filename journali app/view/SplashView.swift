import SwiftUI

struct SplashView: View {
    @State private var isVisible = false

    var body: some View {
        ZStack {
            LinearGradient(colors: [.black, Theme.background],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 12) {
                Image(systemName: "book.closed.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundStyle(
                        LinearGradient(colors: [.orange, Theme.accent],
                                       startPoint: .topLeading,
                                       endPoint: .bottomTrailing)
                    )

                Text("Journali")
                    .font(.system(size: 40, weight: .heavy))
                    .foregroundColor(.white)

                Text("Your thoughts, your story")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            .opacity(isVisible ? 1 : 0)
            .scaleEffect(isVisible ? 1 : 0.9)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                isVisible = true
            }
        }
    }
}

#Preview {
    SplashView()
}
