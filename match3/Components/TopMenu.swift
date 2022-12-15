import SwiftUI

struct TopMenu: View {
    @EnvironmentObject var viewModel: ViewModel

    var body: some View {
        HStack(alignment: .top) {
            Button(
                action: { viewModel.send(update: .showMenu) },
                label: {
                    Image("options")
                })
            Button(
                action: { viewModel.send(update: .showStore) },
                label: {
                    Image("store")
                })
            BalanceView().frame(height: 76)
        }
    }
}

struct TopMenu_Previews: PreviewProvider {
    static var previews: some View {
        TopMenu()
    }
}

