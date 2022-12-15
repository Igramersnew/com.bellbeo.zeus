

import SwiftUI

struct PurchaseButtonView: View {
    @EnvironmentObject var viewModel: ViewModel
    let bonus: Bonus

    var body: some View {
        HStack(spacing: 12.0) {
            Image("purchase")
            Button(
                action: { viewModel.send(update: .buy(bonus)) },
                label: {
                    ZStack {
                        Image("blueButtonBackground").resizable()
                        HStack {
                            Text(String(bonus.cost))
                                .font(.gameFont(fontSize: 32))
                                .foregroundColor(Color.white)
                            Image("clever").resizable().frame(width: 29, height: 29)
                        }
                    }
                }
            ).frame(width: 145, height: 65)
        }
    }
}

struct PurchaseButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseButtonView(bonus: .double)
    }
}
