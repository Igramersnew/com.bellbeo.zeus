import SwiftUI

struct ResultView: View {
    @EnvironmentObject var viewModel: ViewModel

    var body: some View {
        ZStack {
            Image("resultBorder")
            VStack {
                stars()
                    .padding(.bottom, 300)
                Spacer()
            }
            .frame(alignment: .top)

            VStack(spacing: 20.0) {
                Text(viewModel.isWin ? "WIN!" : "LOSE")
                    .font(.gameFont(fontSize: 64))
                    .fontWeight(.heavy)
                    .foregroundColor(Color.orange)
                HStack(spacing: 30.0) {
                    Button(
                        action: { viewModel.send(update: .showMenu) },
                        label: {
                            Image("options")
                                .resizable()
                                .frame(width: 90, height: 90)
                        })
                    Button(
                        action: { viewModel.send(update: .restartGame) },
                        label: {
                            Image("playAgain")
                                .resizable()
                                .frame(width: 90, height: 90)
                        })
                }

            }
        }.frame(width: 301, height: 289)
    }

    @ViewBuilder
    func stars() -> some View {
        if viewModel.isWin {
            HStack(alignment: .bottom) {
                Image("bigStar")
                    .resizable()
                    .frame(width: 90, height: 90)
                Image("bigStar")
                    .padding(.bottom, 10)
                Image("bigStar")
                    .resizable()
                    .frame(width: 90, height: 90)
            }
        }
    }
}

    struct ResultView_Previews: PreviewProvider {
        static var previews: some View {
            ResultView()
                .environmentObject(ViewModel.shared)
        }
    }
