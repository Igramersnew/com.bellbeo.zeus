import SwiftUI

struct MenuView: View {
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var viewModel: ViewModel

    var body: some View {
        NavigationView {
            ZStack {
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                    .navigation(isActive: $viewModel.gameShown) {
                        GameView()
                    }
                VStack {
                    TopMenu()
                    .frame(height: 76)
                    .padding(.horizontal, 20)

                    VStack(spacing: -64.0) {
                        Image("zeus")
                        VStack(spacing: 30.0) {
                            LevelMenu()
                            VStack(spacing: 20.0) {
                                Button(
                                    action: { viewModel.send(update: .startEasy) },
                                    label: {
                                        ZStack {
                                            Image("blueButtonBackground")
                                            Text("Easy")
                                                .font(.gameFont(fontSize: 32))
                                                .foregroundColor(Color.white)
                                                .padding(.bottom, 8)
                                        }
                                    })
                                
                                Button(
                                    action: { viewModel.send(update: .startHard) },
                                    label: {
                                        ZStack {
                                            Image("redButtonBackground")
                                            Text("Hard")
                                                .font(.gameFont(fontSize: 32))
                                                .foregroundColor(Color.white)
                                                .padding(.bottom, 8)
                                        }
                                        
                                    })
                                Text("The difficulty level affects the time limit")
                                    .foregroundColor(Color(hex: "#A93A3A"))
                                Spacer()
                            }
                        }
                    }
                }
            }
            .overlay(storeView)
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
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environmentObject(Settings())
            .environmentObject(ViewModel.shared)
    }
}

