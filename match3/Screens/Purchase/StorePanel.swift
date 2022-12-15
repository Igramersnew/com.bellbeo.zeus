import SwiftUI

struct StorePanel: View {
    @EnvironmentObject private var settings: Settings
    @EnvironmentObject var viewModel: ViewModel

    var body: some View {
        ZStack {
            Image("storeBorder")
            
            VStack(spacing: -30) {
                HStack {
                    Spacer()
                    Button(
                        action: { viewModel.send(update: .hideStore) },
                        label: {
                            Image("closeRed")
                        })
                }
                .padding(.trailing, 40.0)
                VStack {
                    Text("Store")
                        .font(.gameFont(fontSize: 64))
                        .fontWeight(.bold)
                        .foregroundColor(Color.orange)
                    Text("Doubling time")
                        .font(.gameFont(fontSize: 32))
                        .foregroundColor(Color.orange)
                    PurchaseButtonView(bonus: .double)
                    Text("Tripling time")
                        .font(.gameFont(fontSize: 32))
                        .foregroundColor(Color.orange)
                    PurchaseButtonView(bonus: .triple)
                }
            }
            .padding(.top, -80.0)
        }
    }
}
