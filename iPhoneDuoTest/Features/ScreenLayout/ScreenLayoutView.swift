import SwiftUI

struct ScreenLayoutView: View {
    @Environment(\.displayScale) private var displayScale
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass

    private let windowColor = Color.red
    private let safeAreaColor = Color.blue

    var body: some View {
        GeometryReader { proxy in
            let insets = proxy.safeAreaInsets
            let fullSize = CGSize(
                width: proxy.size.width + insets.leading + insets.trailing,
                height: proxy.size.height + insets.top + insets.bottom
            )

            ZStack {
                sizeClassLabel

                VStack(alignment: .leading, spacing: 16) {
                    sizeCard(
                        title: "Window",
                        size: fullSize,
                        detail: "\(format(fullSize * displayScale)) px  @\(format(displayScale))x",
                        color: windowColor
                    )
                    sizeCard(
                        title: "Safe Area",
                        size: proxy.size,
                        detail: nil,
                        color: safeAreaColor
                    )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(24)

                insetLabel("↑ \(format(insets.top))")
                    .frame(maxHeight: .infinity, alignment: .top)
                insetLabel("↓ \(format(insets.bottom))")
                    .frame(maxHeight: .infinity, alignment: .bottom)
                insetLabel("← \(format(insets.leading))")
                    .frame(maxWidth: .infinity, alignment: .leading)
                insetLabel("→ \(format(insets.trailing))")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .background {
                // 下地を不透明にしておかないと、セーフエリア外の塗りと混ざって境界が見えなくなる
                Rectangle()
                    .fill(Color(.systemBackground))
                    .overlay(safeAreaColor.opacity(0.12))
                    .overlay(Rectangle().strokeBorder(safeAreaColor, lineWidth: 6))
            }
        }
        .background(windowColor.opacity(0.25).ignoresSafeArea())
    }

    private var sizeClassLabel: some View {
        VStack(spacing: 4) {
            Text("Size Class")
                .font(.title3.bold())
                .foregroundStyle(.secondary)
            Grid(alignment: .leading, horizontalSpacing: 16) {
                GridRow {
                    Text("H")
                        .foregroundStyle(.secondary)
                    Text(describe(horizontalSizeClass))
                }
                GridRow {
                    Text("V")
                        .foregroundStyle(.secondary)
                    Text(describe(verticalSizeClass))
                }
            }
            .font(.system(size: 40, weight: .bold, design: .rounded))
            .minimumScaleFactor(0.5)
        }
        // 左右端のインセットラベルと重ならないよう、その分の幅を空けておく
        .padding(.horizontal, 64)
    }

    private func sizeCard(title: String, size: CGSize, detail: String?, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.headline)
            Text("\(format(size)) pt")
                .font(.system(size: 32, weight: .bold, design: .rounded))
            if let detail {
                Text(detail)
                    .font(.subheadline)
            }
        }
        .monospacedDigit()
        .foregroundStyle(color)
        .padding(12)
        .background(color.opacity(0.15), in: .rect(cornerRadius: 12))
    }

    private func insetLabel(_ text: String) -> some View {
        Text(text)
            .font(.headline)
            .monospacedDigit()
            .foregroundStyle(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(safeAreaColor, in: .capsule)
            .padding(4)
    }

    private func format(_ value: CGFloat) -> String {
        Double(value).formatted(.number.precision(.fractionLength(0...1)))
    }

    private func format(_ size: CGSize) -> String {
        "\(format(size.width)) × \(format(size.height))"
    }

    private func describe(_ sizeClass: UserInterfaceSizeClass?) -> String {
        switch sizeClass {
        case .compact: "compact"
        case .regular: "regular"
        default: "unknown"
        }
    }
}

private extension CGSize {
    static func * (size: CGSize, scale: CGFloat) -> CGSize {
        CGSize(width: size.width * scale, height: size.height * scale)
    }
}

#Preview {
    ScreenLayoutView()
}
