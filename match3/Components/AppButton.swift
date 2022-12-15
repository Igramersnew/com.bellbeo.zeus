import SwiftUI

struct AppButton: View {
    @State var isPressed: Bool = false
    
    let normalImage: String
    let pressedImage: String
    let text: String
    
    let onAction: () -> Void
    
    var body: some View {
        Image(!isPressed ? normalImage : pressedImage)
                    .resizable()
                    .overlay(
                        GeometryReader { geometry in
                            Button(action: { }, label: {
                                Text(text)
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                    .contentShape(Rectangle())
                                    .foregroundColor(.white)
                                    //.font(AppFont.boldFont(fontSize: 16))
                            })
                            .buttonStyle(PlainButtonStyle())
                            .pressAction {
                                isPressed = true
                            } onRelease: {
                                isPressed = false
                                onAction()
                            }
                        }
                    )
    }
}

struct PressActions: ViewModifier {
    var onPress: () -> Void
    var onRelease: () -> Void
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ _ in
                        onPress()
                    })
                    .onEnded({ _ in
                        onRelease()
                    })
            )
    }
}


extension View {
    func pressAction(onPress: @escaping (() -> Void), onRelease: @escaping (() -> Void)) -> some View {
        modifier(PressActions(onPress: {
            onPress()
        }, onRelease: {
            onRelease()
        }))
    }
}
