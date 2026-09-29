import SwiftUI

struct ToolbarSampleView: View {
    @State private var isVerticalEnabled = true
    @State private var compression: ToolbarVerticalCompressionBehavior = .automatic
    @State private var lastTapped = "-"

    var body: some View {
        NavigationStack {
            List {
                Section("Status") {
                    VerticalEdgeRow()
                    LabeledContent("Last tapped", value: lastTapped)
                }

                Section("Settings") {
                    Toggle("Vertical toolbar", isOn: $isVerticalEnabled)
                    Picker("Compression", selection: $compression) {
                        Text("automatic").tag(ToolbarVerticalCompressionBehavior.automatic)
                        Text("prefersToolbarItems").tag(ToolbarVerticalCompressionBehavior.prefersToolbarItems)
                        Text("prefersTabBar").tag(ToolbarVerticalCompressionBehavior.prefersTabBar)
                    }
                }

                Section("Items") {
                    itemRow("a.circle", "axisBehavior(.automatic)")
                    itemRow("arrow.left.and.right", "axisBehavior(.horizontalOnly)")
                    itemRow("arrow.up.and.down", "axisBehavior(.verticalPreferred)")
                    itemRow("square.and.arrow.up", "visibilityPriority(.high)")
                    itemRow("trash", "visibilityPriority(.low)")
                    itemRow("checkmark", "placement: .topBarPinnedTrailing")
                    itemRow("ellipsis", "ToolbarOverflowMenu")
                }
            }
            .navigationTitle("Toolbar")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    button("Automatic", systemImage: "a.circle")
                }
                .axisBehavior(.automatic)

                ToolbarItem(placement: .primaryAction) {
                    button("Horizontal Only", systemImage: "arrow.left.and.right")
                }
                .axisBehavior(.horizontalOnly)

                ToolbarItem(placement: .primaryAction) {
                    button("Vertical Preferred", systemImage: "arrow.up.and.down")
                }
                .axisBehavior(.verticalPreferred)

                ToolbarItem(placement: .primaryAction) {
                    button("Share", systemImage: "square.and.arrow.up")
                }
                .visibilityPriority(.high)

                ToolbarItem(placement: .primaryAction) {
                    button("Delete", systemImage: "trash")
                }
                .visibilityPriority(.low)

                ToolbarItem(placement: .topBarPinnedTrailing) {
                    button("Done", systemImage: "checkmark")
                }

                ToolbarOverflowMenu {
                    button("Export", systemImage: "square.and.arrow.down")
                }
            }
            .toolbarVerticalBehavior(isVerticalEnabled ? .automatic : .disabled)
            .toolbarVerticalCompressionBehavior(compression)
        }
    }

    private func button(_ title: String, systemImage: String) -> some View {
        Button(title, systemImage: systemImage) {
            lastTapped = title
        }
    }

    private func itemRow(_ systemImage: String, _ description: String) -> some View {
        Label {
            Text(description)
                .font(.callout.monospaced())
        } icon: {
            Image(systemName: systemImage)
        }
    }
}

// toolbarVerticalEdge は NavigationStack 配下で解決されるため、子 View で読む
private struct VerticalEdgeRow: View {
    @Environment(\.toolbarVerticalEdge) private var edge

    var body: some View {
        LabeledContent("Vertical edge", value: description)
    }

    private var description: String {
        switch edge {
        case .leading: "leading"
        case .trailing: "trailing"
        case nil: "none (horizontal)"
        }
    }
}

#Preview {
    ToolbarSampleView()
}
