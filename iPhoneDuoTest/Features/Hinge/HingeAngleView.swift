import SwiftUI

struct HingeAngleView: View {
    @State private var foldingAngle: Double = 0

    var body: some View {
        VStack(spacing: 16) {
            Text("Hinge Angle")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.secondary)

            Text("\(foldingAngle, format: .number.precision(.fractionLength(1)))°")
                .font(.system(size: 96, weight: .bold, design: .rounded))
                .monospacedDigit()
        }
        .onHingeChange { oldContext, newContext in
            guard let hinge = newContext.hinge else { return }
            foldingAngle = hinge.angle.degrees
        }
    }
}

#Preview {
    HingeAngleView()
}
