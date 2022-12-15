import SwiftUI
import AppTrackingTransparency
import AppsFlyerLib

struct SplashView: View {
    @EnvironmentObject private var viewModel: ViewModel
    @EnvironmentObject private var settings: Settings
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 0) {
                Image("zeus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 294, height: 294)
                VStack(spacing: 16) {
                    Text("Loading...")
                        .font(.gameFont(fontSize: 24))
                        .foregroundColor(.white)
                    CircularProgressView().frame(width: 54)
                }
            }
            .padding(.bottom, 120)
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                viewModel.send(update: .start)
            }
        }
    }
}


struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
            .environmentObject(ViewModel.shared)
    }
}
