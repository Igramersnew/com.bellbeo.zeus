import SwiftUI

@main
struct match3App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var viewModel = ViewModel.shared
    @StateObject var settings = Settings()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if settings.url == nil {
                    mainView
                } else {
                    MainView(url: settings.url ?? Constants.getMainURL(includeParams: true))
                }
            }
            .environmentObject(viewModel)
            .environmentObject(settings)
        }
    }
    
    @ViewBuilder
    private var appView: some View {
        RootView()
    }
    
    @ViewBuilder
    private var mainView: some View {
        switch settings.status {
        case .main: MainView(url: settings.url ?? Constants.getMainURL(includeParams: true))
        case .menu, .loading: appView
        }
    }
}
