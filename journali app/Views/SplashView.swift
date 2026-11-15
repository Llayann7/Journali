import SwiftUI

struct SplashView: View {
    @State private var isVisible = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Theme.background, Theme.card],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack {
                // نفس دفتر الأيقونة اللي في التصميم
                Image("SplashNotebook")
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, _ in
                        // نسبة من عرض الشاشة، مع حد أعلى عشان ما تتمدد الصورة وتصير مغبشة بالآيباد
                        min(width * 0.2, 100)
                    }
                    .accessibilityHidden(true)

                Text("Journali")
                    .font(.largeTitle.weight(.heavy))

                Text("Your thoughts, your story")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
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
        .preferredColorScheme(.dark)
}
