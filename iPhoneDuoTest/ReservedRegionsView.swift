import SwiftUI

struct ReservedRegionsView: View {
    private struct Entry: Identifiable {
        let region: ReservedRegion
        let name: String
        let color: Color

        var id: ReservedRegion.ID { region.id }
    }

    private static let occlusionColors: [Color] = [.blue, .green, .orange, .purple]

    var body: some View {
        GeometryReader { proxy in
            let regions = entries(
                divisions: proxy.reservedRegions(kind: .division, options: .includeInactive),
                occlusions: proxy.reservedRegions(kind: .occlusion, options: .includeInactive)
            )

            ZStack {
                ForEach(regions) { entry in
                    regionShape(entry)
                        .frame(width: entry.region.frame.width, height: entry.region.frame.height)
                        .position(x: entry.region.frame.midX, y: entry.region.frame.midY)
                }

                regionList(regions)
            }
        }
        // occlusion はカメラやステータス表示など画面端にあるため、座標系を画面全体に合わせる
        .ignoresSafeArea()
    }

    private func entries(divisions: [ReservedRegion], occlusions: [ReservedRegion]) -> [Entry] {
        let hinges = divisions.map { Entry(region: $0, name: "division (hinge)", color: .red) }
        let occluded = occlusions.enumerated().map { index, region in
            Entry(
                region: region,
                name: "occlusion \(index + 1)",
                color: Self.occlusionColors[index % Self.occlusionColors.count]
            )
        }
        return hinges + occluded
    }

    @ViewBuilder
    private func regionShape(_ entry: Entry) -> some View {
        if entry.region.isActive {
            Rectangle()
                .fill(entry.color.opacity(0.6))
        } else {
            Rectangle()
                .strokeBorder(entry.color, style: StrokeStyle(lineWidth: 2, dash: [6, 4]))
        }
    }

    private func regionList(_ regions: [Entry]) -> some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Reserved Regions")
                .font(.largeTitle.bold())
            if regions.isEmpty {
                Text("なし")
                    .font(.title3)
                    .foregroundStyle(.secondary)
            }
            ForEach(regions) { entry in
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Circle()
                            .fill(entry.color)
                            .frame(width: 16, height: 16)
                        Text(entry.name)
                            .font(.title2.bold())
                        Text(entry.region.isActive ? "active" : "inactive")
                            .font(.headline)
                            .foregroundStyle(entry.region.isActive ? .primary : .secondary)
                    }
                    Text(describe(entry.region.frame))
                        .font(.body)
                        .monospacedDigit()
                        .foregroundStyle(.secondary)
                }
            }
            legend
        }
        .minimumScaleFactor(0.7)
        .padding(24)
        .background(.regularMaterial, in: .rect(cornerRadius: 20))
        .padding()
    }

    private var legend: some View {
        HStack(spacing: 20) {
            Label("active", systemImage: "square.fill")
            Label("inactive", systemImage: "square.dashed")
        }
        .font(.subheadline)
        .foregroundStyle(.secondary)
    }

    private func describe(_ frame: CGRect) -> String {
        func format(_ value: CGFloat) -> String {
            Double(value).formatted(.number.precision(.fractionLength(0...1)))
        }
        return "x: \(format(frame.minX)), y: \(format(frame.minY)), \(format(frame.width)) × \(format(frame.height))"
    }
}

#Preview {
    ReservedRegionsView()
}
