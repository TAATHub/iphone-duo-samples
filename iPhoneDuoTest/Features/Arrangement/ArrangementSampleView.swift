import SwiftUI

struct ArrangementSampleView: View {
    enum Sample: String, CaseIterable, Identifiable {
        case basic = "Basic (overlay)"
        case mediaPlayer = "Player (overlay)"
        case lyrics = "Lyrics (split)"

        var id: Self { self }
    }

    @State private var sample: Sample = .basic

    var body: some View {
        Group {
            switch sample {
            case .basic:
                ArrangementView {
                    LabeledPane(title: "Primary View", color: .red)
                } secondary: {
                    LabeledPane(title: "Secondary View", color: .blue)
                }
                .arrangementViewStyle(.overlay)
            case .mediaPlayer:
                ArrangementView {
                    PlayerControls()
                } secondary: {
                    VideoSurface()
                }
                .arrangementViewStyle(.overlay)
            case .lyrics:
                ArrangementView {
                    NowPlayingView()
                } secondary: {
                    LyricsView()
                }
                .arrangementViewStyle(.split)
            }
        }
        .safeAreaInset(edge: .top) {
            Picker("Sample", selection: $sample) {
                ForEach(Sample.allCases) { sample in
                    Text(sample.rawValue).tag(sample)
                }
            }
            .pickerStyle(.segmented)
            .fixedSize()
            .padding(8)
        }
    }
}

private struct LabeledPane: View {
    let title: String
    let color: Color

    var body: some View {
        Text(title)
            .font(.title2.bold())
            .foregroundStyle(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(color)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(color.opacity(0.1), ignoresSafeAreaEdges: [])
    }
}

private struct VideoSurface: View {
    var body: some View {
        LinearGradient(colors: [.indigo, .purple, .pink], startPoint: .topLeading, endPoint: .bottomTrailing)
            .overlay {
                Image(systemName: "film")
                    .font(.system(size: 64))
                    .foregroundStyle(.white.opacity(0.4))
            }
    }
}

private struct PlayerControls: View {
    @State private var isPlaying = false
    @State private var progress = 0.3

    var body: some View {
        VStack(spacing: 12) {
            Text("Sample Movie")
                .font(.headline)
            Slider(value: $progress)
            HStack(spacing: 40) {
                Button("Back", systemImage: "gobackward.10") {
                    progress = max(progress - 0.1, 0)
                }
                Button(isPlaying ? "Pause" : "Play", systemImage: isPlaying ? "pause.fill" : "play.fill") {
                    isPlaying.toggle()
                }
                .font(.largeTitle)
                Button("Forward", systemImage: "goforward.10") {
                    progress = min(progress + 0.1, 1)
                }
            }
            .labelStyle(.iconOnly)
            .font(.title2)
        }
        .foregroundStyle(.white)
        .tint(.white)
        .padding()
        .background(.black.opacity(0.5), in: .rect(cornerRadius: 16))
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }
}

private struct NowPlayingView: View {
    @State private var isPlaying = true

    var body: some View {
        VStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 16)
                .fill(LinearGradient(colors: [.pink, .orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                .aspectRatio(1, contentMode: .fit)
                .frame(maxWidth: 240)
                .overlay {
                    Image(systemName: "music.note")
                        .font(.system(size: 64))
                        .foregroundStyle(.white)
                }
            VStack(spacing: 4) {
                Text("Sample Song")
                    .font(.title2.bold())
                Text("Sample Artist")
                    .foregroundStyle(.secondary)
            }
            HStack(spacing: 40) {
                Button("Previous", systemImage: "backward.fill") {}
                Button(isPlaying ? "Pause" : "Play", systemImage: isPlaying ? "pause.fill" : "play.fill") {
                    isPlaying.toggle()
                }
                .font(.largeTitle)
                Button("Next", systemImage: "forward.fill") {}
            }
            .labelStyle(.iconOnly)
            .font(.title2)
            .tint(.primary)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

private struct LyricsView: View {
    private let lines = [
        "Morning light taps on the window",
        "Walking through a sleepy town",
        "A view that opens past the hinge",
        "One screen turning into two",
        "Open, close, and open again",
        "Things unseen come into view",
        "Words on the left, melody on the right",
        "Still playing somewhere today",
    ]
    private let currentIndex = 2

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(lines.indices, id: \.self) { index in
                    Text(lines[index])
                        .font(.title3.bold())
                        .foregroundStyle(index == currentIndex ? .primary : .tertiary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .background(Color(.secondarySystemBackground), ignoresSafeAreaEdges: [])
    }
}

#Preview {
    ArrangementSampleView()
}
