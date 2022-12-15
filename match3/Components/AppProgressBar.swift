import SwiftUI

struct AppProgressBar: View {
    var duration = 1.5
    @State private var width: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Image("loading_background")
                    .resizable()
                    .frame(width: geometry.size.width , height: geometry.size.height)
                
                Image("loading_bar")
                    .resizable()
                    .frame(width: width, height: geometry.size.height-16)
                    .padding(.trailing, 8)
                    .padding(.leading, 10)
            }
            .onAppear {
                withAnimation(.linear(duration: duration)) {
                    width = geometry.size.width-20
                }
            }
        }
    }
}

struct AppProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        AppProgressBar()
            .frame(height: 44)
    }
}
