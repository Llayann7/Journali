import SwiftUI
import SwiftData

@main
struct MyApp: App {
    @State private var isShowingSplash = true

    var body: some Scene {
        WindowGroup {
            ZStack {
                if isShowingSplash {
                    SplashView()
                        .transition(.opacity)
                } else {
                    JournalListView()
                        .transition(.opacity)
                }
            }
            .preferredColorScheme(.dark)
            .tint(Theme.primaryAccent)
            .task {
                try? await Task.sleep(for: .seconds(2))
                withAnimation(.easeInOut(duration: 0.5)) {
                    isShowingSplash = false
                }
            }
        }
        .modelContainer(for: Journal.self)
    }
}
