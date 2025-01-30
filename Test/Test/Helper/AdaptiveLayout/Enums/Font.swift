import UIKit


enum SFPro {
    
    static func bold(size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size.adaptedFontSize, weight: .bold)
    }
    
    static func medium(size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size.adaptedFontSize, weight: .medium)
    }
    
    static func regular(size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size.adaptedFontSize, weight: .regular)
    }
    
    static func semibold(size: CGFloat) -> UIFont {
        UIFont.systemFont(ofSize: size.adaptedFontSize, weight: .semibold)
    }
}
