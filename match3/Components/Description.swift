import SwiftUI

struct Description: View {
    @EnvironmentObject var viewModel: ViewModel

    var body: some View {
        HStack(spacing: 12.0) {
            //  Image("purchase")
            ZStack {
                Image("screenPhone")
                Image("framePhone")
                HStack {

                    Image("line")

                    Image("line")

                    Image("line")

                }.frame(width: 248, height: 470)
                    .padding(.top, 60)
            }
        }
    }
}

struct Description_Previews: PreviewProvider {
    static var previews: some View {
        Description()
            .environmentObject(ViewModel.shared)
    }
}
