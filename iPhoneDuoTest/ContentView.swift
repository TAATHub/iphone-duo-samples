import SwiftUI
import Playgrounds

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("ヒンジ", systemImage: "angle") {
                HingeAngleView()
            }
            Tab("レイアウト", systemImage: "rectangle.dashed") {
                ScreenLayoutView()
            }
            Tab("Sample 3", systemImage: "3.square") {
                PlaceholderView(title: "Sample 3")
            }
            Tab("Sample 4", systemImage: "4.square") {
                PlaceholderView(title: "Sample 4")
            }
            Tab("Sample 5", systemImage: "5.square") {
                PlaceholderView(title: "Sample 5")
            }
        }
    }
}

#Preview {
    ContentView()
}

#Playground {
    _ = 1 + 2
}
