import SwiftUI

class Screen {
    public static var bounds: CGRect {
        #if canImport(UIKit)
        return CGRect(x: 0, y: 0, width: 100, height: 100)
        #else
        return NSScreen.main?.frame ?? CGRect()
        #endif
    }
}
