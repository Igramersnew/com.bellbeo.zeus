import SwiftUI

struct GameProgress: View {
    @EnvironmentObject var viewModel: ViewModel

    private let progressLength: CGFloat = 237
    private let hiddenLength: CGFloat = 35

    var body: some View {
        HStack(spacing: -40) {
            Image("progressIcon")
                .zIndex(1)
            Image("progressBar")
                .frame(width: progressLength)
                .zIndex(0)
                .mask(
                    HStack {
                        Rectangle().frame(width: calculateCover())
                        Spacer()
                    }
                )
        }
    }

    private func calculateCover() -> CGFloat {
        return (progressLength - hiddenLength) * CGFloat(viewModel.timeLeft) / CGFloat(viewModel.timeLimit) + hiddenLength
    }
}

struct GameProgress_Previews: PreviewProvider {
    static var previews: some View {
        GameProgress()
    }
}
