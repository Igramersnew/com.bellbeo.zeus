import SwiftUI

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject private var settings: Settings
    @EnvironmentObject private var viewModel: ViewModel

    @State private var shouldReloadBoard = false
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            VStack {
                TopMenu()
                GameProgress()
                Match3View(reloadBoard: $shouldReloadBoard)
                    .frame(maxHeight: .infinity)

                Text("Assemble the crystals into vertical stripes by color")
                    .font(.gameFont(fontSize: 15))
                    .foregroundColor(Color(hex: "#A93A3A"))
                    .multilineTextAlignment(.center)
                    .frame(width: 270)
                    .lineSpacing(16)

            }.padding(.all, 20)
            .overlay(gameEndedOverlay())
            .overlay(storeView)
            .background(Image(settings.selectedBackground)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea())
            .navigationBarBackButtonHidden(true)
        }
    }

    @ViewBuilder
    private var storeView: some View {
        if viewModel.storeShown {
            StorePanel()
                .transition(.opacity)
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    private func gameEndedOverlay() -> some View {
        if viewModel.isFinished {
            ResultView()
                .transition(.opacity)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(Settings())
            .environmentObject(ViewModel.shared)
    }
}
