import SwiftUI

struct RootView: View {
    @EnvironmentObject var viewModel: ViewModel
    @EnvironmentObject private var settings: Settings
    
    var body: some View {
        switch viewModel.currentScreen {
        case .loading:
            DescriptionView()
        case .menu:
            MenuView()
        }
    }
}
