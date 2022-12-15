import SwiftUI

struct BalanceView: View {
    @EnvironmentObject var viewModel: ViewModel

    var body: some View {
        ZStack {
            Image("scoreBorder")
            HStack {
                Image("clever")
                Spacer()
                Text(String(viewModel.score))
                    .font(.gameFont(fontSize: 28))
                    .fontWeight(.bold)
                    .foregroundColor(Color.orange)
            }
            .padding(EdgeInsets(top: 13, leading: 26, bottom: 19, trailing: 26))
        }
    }
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceView()
            .previewLayout(.fixed(width: 170, height: 76))
    }
}
