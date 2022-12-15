import SwiftUI

@main
struct match3App: App {
    
    @StateObject var viewModel = ViewModel.shared
    @StateObject var settings = Settings()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(viewModel)
                .environmentObject(settings)
        }
    }
}
