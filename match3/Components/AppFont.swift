import Foundation
import SwiftUI

extension SwiftUI.Font {
    static func regularFont(fontSize: CGFloat) -> Font {
        return Font.custom("Humanist777BT-LightB", size: fontSize)
    }
    
    static func boldFont(fontSize: CGFloat) -> Font {
        return Font.custom("Humanist777BT-LightB", size: fontSize)
    }
    
    static func semiBoldFont(fontSize: CGFloat) -> Font {
        return Font.custom("Humanist777BT-LightB", size: fontSize)
    }
    
    static func gameFont(fontSize: CGFloat) -> Font {
        return .system(size: fontSize)
    }
}
