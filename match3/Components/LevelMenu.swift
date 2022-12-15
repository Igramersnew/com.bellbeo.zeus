import SwiftUI

struct LevelMenu: View {
    @EnvironmentObject var viewModel: ViewModel

    var body: some View {
        HStack(spacing: 15.0) {
            Button(
                action: { viewModel.send(update: .previousLevel) },
                label: {
                    Image("leftArrow")
                }
            )
            ZStack {
                Image("levelBorder")
                VStack {
                    Spacer()
                    stars()
                }
                VStack(spacing: 8.0) {
                    Text("level")
                        .font(.gameFont(fontSize: 32))
                        .fontWeight(.medium)
                        .foregroundColor(Color.orange)
                    Text(String(viewModel.level))
                        .font(.gameFont(fontSize: 64))
                        .fontWeight(.bold)
                        .foregroundColor(Color.orange)
                    Spacer()
                }
                .padding(.top, 10)
            }.frame(width: 176, height: 176)
            Button(
                action: { viewModel.send(update: .nextLevel) },
                label: {
                    Image("rightArrow")
                }
            )
        }
    }

    @ViewBuilder
    func stars() -> some View {
        if viewModel.level < viewModel.maxLevel {
            HStack(alignment: .bottom) {
                Image("star")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.bottom, 12)
                Image("star")
                    .resizable()
                    .frame(width: 75, height: 75)
                    .padding(.bottom, -25)
                Image("star")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.bottom, 12)
            }
        }
    }
}

struct LevelMenu_Previews: PreviewProvider {
    static var previews: some View {
        LevelMenu()
            .previewLayout(.fixed(width: 380, height: 200))
            .environmentObject(ViewModel.shared)
    }
}
