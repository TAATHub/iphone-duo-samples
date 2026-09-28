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
            Tab("配置", systemImage: "rectangle.split.2x1") {
                ArrangementSampleView()
            }
            Tab("予約領域", systemImage: "camera.metering.center.weighted") {
                ReservedRegionsView()
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
