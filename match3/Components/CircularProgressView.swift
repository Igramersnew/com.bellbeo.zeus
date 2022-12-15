import SwiftUI

struct CircularProgressView: View {
    @State private var degrees: Double = -90

    var body: some View {
        ZStack {
            Circle().stroke(Color.white.opacity(0.2), lineWidth: 5)
            Circle()
                .trim(from: 0, to: 0.25)
                .stroke(Color.white, style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .rotationEffect(.degrees(degrees))
                .onAppear {
                    withAnimation(.linear(duration: 5)) {
                        degrees = 3000
                    }
                }
        }
    }
}

