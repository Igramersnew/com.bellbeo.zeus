import SwiftUI

struct DescriptionView: View {
    @EnvironmentObject private var viewModel: ViewModel
    @EnvironmentObject private var settings: Settings

    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 18) {
                VStack(spacing: 8) {
                    Text("Welcome")
                        .font(.gameFont(fontSize: 20))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .lineSpacing(8)
                    Text("Collect colored crystals in columns for a while, moving the pebbles among themselves. Time is limited")
                        .font(.gameFont(fontSize: 20))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .lineSpacing(8)
                }
                VStack(spacing: 37) {
                    Image("framePhone")
                    Button(
                        action:
                            { viewModel.send(update: .start) },
                        label: {
                            ZStack {
                                Image("blueButtonBackground")
                                Text("Continue")
                                    .font(.gameFont(fontSize: 30))
                                    .foregroundColor(.white)
                                    .padding(.bottom, 8)
                            }
                        }
                    )
                }
            }
            .padding(.bottom, 54)
            .onAppear {
                viewModel.send(update: .descriptionShown)
            }
        }
    }
}


struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView()
            .previewDevice("iPhone 13 mini")
            .previewDisplayName("iPhone 13")
            .environmentObject(Settings())
            .environmentObject(ViewModel.shared)
    }
}

