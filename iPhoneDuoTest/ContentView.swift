import SwiftUI
import Playgrounds

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Hinge", systemImage: "angle") {
                HingeAngleView()
            }
            Tab("Layout", systemImage: "rectangle.dashed") {
                ScreenLayoutView()
            }
            Tab("Arrangement", systemImage: "rectangle.split.2x1") {
                ArrangementSampleView()
            }
            Tab("Regions", systemImage: "camera.metering.center.weighted") {
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
