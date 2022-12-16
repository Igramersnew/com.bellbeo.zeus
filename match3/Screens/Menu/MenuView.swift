import SwiftUI

struct MenuView: View {
    @EnvironmentObject var settings: Settings
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                TopMenu()
                    .padding(.horizontal, 20)
                    .navigation(isActive: $viewModel.gameShown) {
                        GameView()
                    }
                
                Spacer()
                

                VStack(spacing: 24.0) {
                    LevelMenu()
                    
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
                }
                .padding(.bottom)
            }
            .background(
                Image("background")
                .resizable()
                .ignoresSafeArea()
                .overlay(Image("zeus")
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom, 100)
                ))
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

