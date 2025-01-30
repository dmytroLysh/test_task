import UIKit

enum Device {
    case iPhoneSE
    case iPhone7
    case iPhone8Plus
    case iPhone11Pro
    case iPhone11ProMax
    case iPhone13
    case iPhone13ProMax
    case iPhone14Pro
    case iPhone14ProMax
    
    static let baseScreenSize: Device = .iPhone13
}

extension Device: RawRepresentable {
    
    typealias RawValue = CGSize
    
    init?(rawValue: CGSize) {
        switch rawValue {
        case CGSize(width: 320, height: 568):
            self = .iPhoneSE
        case CGSize(width: 375, height: 667):
            self = .iPhone7
        case CGSize(width: 414, height: 736):
            self = .iPhone8Plus
        case CGSize(width: 375, height: 812):
            self = .iPhone11Pro
        case CGSize(width: 414, height: 896):
            self = .iPhone11ProMax
        case CGSize(width: 390, height: 844):
            self = .iPhone13
        case CGSize(width: 428, height: 926):
            self = .iPhone13ProMax
        case CGSize(width: 393, height: 852):
            self = .iPhone14Pro
        case CGSize(width: 430, height: 932):
            self = .iPhone14ProMax
        default:
            return nil
        }
    }
    
    var rawValue: CGSize {
        switch self {
        case .iPhoneSE:
            return CGSize(width: 320, height: 568)
        case .iPhone7:
            return CGSize(width: 375, height: 667)
        case .iPhone8Plus:
            return CGSize(width: 414, height: 736)
        case .iPhone11Pro:
            return CGSize(width: 375, height: 812)
        case .iPhone11ProMax:
            return CGSize(width: 414, height: 896)
        case .iPhone13:
            return CGSize(width: 390, height: 844)
        case .iPhone13ProMax:
            return CGSize(width: 428, height: 926)
        case .iPhone14Pro:
            return CGSize(width: 393, height: 852)
        case .iPhone14ProMax:
            return CGSize(width: 430, height: 932)
        }
    }
}


