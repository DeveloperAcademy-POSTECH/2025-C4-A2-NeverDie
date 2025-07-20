import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ColorResource {

    /// The "black01" asset catalog color resource.
    static let black01 = DeveloperToolsSupport.ColorResource(name: "black01", bundle: resourceBundle)

    /// The "blue01" asset catalog color resource.
    static let blue01 = DeveloperToolsSupport.ColorResource(name: "blue01", bundle: resourceBundle)

    /// The "brown01" asset catalog color resource.
    static let brown01 = DeveloperToolsSupport.ColorResource(name: "brown01", bundle: resourceBundle)

    /// The "brown02" asset catalog color resource.
    static let brown02 = DeveloperToolsSupport.ColorResource(name: "brown02", bundle: resourceBundle)

    /// The "grayCaption00" asset catalog color resource.
    static let grayCaption00 = DeveloperToolsSupport.ColorResource(name: "grayCaption00", bundle: resourceBundle)

    /// The "grayCaption01" asset catalog color resource.
    static let grayCaption01 = DeveloperToolsSupport.ColorResource(name: "grayCaption01", bundle: resourceBundle)

    /// The "grayCaption02" asset catalog color resource.
    static let grayCaption02 = DeveloperToolsSupport.ColorResource(name: "grayCaption02", bundle: resourceBundle)

    /// The "grayCaption03" asset catalog color resource.
    static let grayCaption03 = DeveloperToolsSupport.ColorResource(name: "grayCaption03", bundle: resourceBundle)

    /// The "green01" asset catalog color resource.
    static let green01 = DeveloperToolsSupport.ColorResource(name: "green01", bundle: resourceBundle)

    /// The "green02" asset catalog color resource.
    static let green02 = DeveloperToolsSupport.ColorResource(name: "green02", bundle: resourceBundle)

    /// The "green03" asset catalog color resource.
    static let green03 = DeveloperToolsSupport.ColorResource(name: "green03", bundle: resourceBundle)

    /// The "greenChart01Linear01" asset catalog color resource.
    static let greenChart01Linear01 = DeveloperToolsSupport.ColorResource(name: "greenChart01Linear01", bundle: resourceBundle)

    /// The "greenChart01Linear02" asset catalog color resource.
    static let greenChart01Linear02 = DeveloperToolsSupport.ColorResource(name: "greenChart01Linear02", bundle: resourceBundle)

    /// The "greenChart02" asset catalog color resource.
    static let greenChart02 = DeveloperToolsSupport.ColorResource(name: "greenChart02", bundle: resourceBundle)

    /// The "orange01" asset catalog color resource.
    static let orange01 = DeveloperToolsSupport.ColorResource(name: "orange01", bundle: resourceBundle)

    /// The "white01" asset catalog color resource.
    static let white01 = DeveloperToolsSupport.ColorResource(name: "white01", bundle: resourceBundle)

}

// MARK: - Image Symbols -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension DeveloperToolsSupport.ImageResource {

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// The "black01" asset catalog color.
    static var black01: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .black01)
#else
        .init()
#endif
    }

    /// The "blue01" asset catalog color.
    static var blue01: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .blue01)
#else
        .init()
#endif
    }

    /// The "brown01" asset catalog color.
    static var brown01: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .brown01)
#else
        .init()
#endif
    }

    /// The "brown02" asset catalog color.
    static var brown02: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .brown02)
#else
        .init()
#endif
    }

    /// The "grayCaption00" asset catalog color.
    static var grayCaption00: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .grayCaption00)
#else
        .init()
#endif
    }

    /// The "grayCaption01" asset catalog color.
    static var grayCaption01: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .grayCaption01)
#else
        .init()
#endif
    }

    /// The "grayCaption02" asset catalog color.
    static var grayCaption02: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .grayCaption02)
#else
        .init()
#endif
    }

    /// The "grayCaption03" asset catalog color.
    static var grayCaption03: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .grayCaption03)
#else
        .init()
#endif
    }

    /// The "green01" asset catalog color.
    static var green01: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .green01)
#else
        .init()
#endif
    }

    /// The "green02" asset catalog color.
    static var green02: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .green02)
#else
        .init()
#endif
    }

    /// The "green03" asset catalog color.
    static var green03: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .green03)
#else
        .init()
#endif
    }

    /// The "greenChart01Linear01" asset catalog color.
    static var greenChart01Linear01: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .greenChart01Linear01)
#else
        .init()
#endif
    }

    /// The "greenChart01Linear02" asset catalog color.
    static var greenChart01Linear02: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .greenChart01Linear02)
#else
        .init()
#endif
    }

    /// The "greenChart02" asset catalog color.
    static var greenChart02: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .greenChart02)
#else
        .init()
#endif
    }

    /// The "orange01" asset catalog color.
    static var orange01: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .orange01)
#else
        .init()
#endif
    }

    /// The "white01" asset catalog color.
    static var white01: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .white01)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// The "black01" asset catalog color.
    static var black01: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .black01)
#else
        .init()
#endif
    }

    /// The "blue01" asset catalog color.
    static var blue01: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .blue01)
#else
        .init()
#endif
    }

    /// The "brown01" asset catalog color.
    static var brown01: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .brown01)
#else
        .init()
#endif
    }

    /// The "brown02" asset catalog color.
    static var brown02: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .brown02)
#else
        .init()
#endif
    }

    /// The "grayCaption00" asset catalog color.
    static var grayCaption00: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .grayCaption00)
#else
        .init()
#endif
    }

    /// The "grayCaption01" asset catalog color.
    static var grayCaption01: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .grayCaption01)
#else
        .init()
#endif
    }

    /// The "grayCaption02" asset catalog color.
    static var grayCaption02: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .grayCaption02)
#else
        .init()
#endif
    }

    /// The "grayCaption03" asset catalog color.
    static var grayCaption03: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .grayCaption03)
#else
        .init()
#endif
    }

    /// The "green01" asset catalog color.
    static var green01: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .green01)
#else
        .init()
#endif
    }

    /// The "green02" asset catalog color.
    static var green02: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .green02)
#else
        .init()
#endif
    }

    /// The "green03" asset catalog color.
    static var green03: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .green03)
#else
        .init()
#endif
    }

    /// The "greenChart01Linear01" asset catalog color.
    static var greenChart01Linear01: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .greenChart01Linear01)
#else
        .init()
#endif
    }

    /// The "greenChart01Linear02" asset catalog color.
    static var greenChart01Linear02: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .greenChart01Linear02)
#else
        .init()
#endif
    }

    /// The "greenChart02" asset catalog color.
    static var greenChart02: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .greenChart02)
#else
        .init()
#endif
    }

    /// The "orange01" asset catalog color.
    static var orange01: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .orange01)
#else
        .init()
#endif
    }

    /// The "white01" asset catalog color.
    static var white01: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .white01)
#else
        .init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

    /// The "black01" asset catalog color.
    static var black01: SwiftUI.Color { .init(.black01) }

    /// The "blue01" asset catalog color.
    static var blue01: SwiftUI.Color { .init(.blue01) }

    /// The "brown01" asset catalog color.
    static var brown01: SwiftUI.Color { .init(.brown01) }

    /// The "brown02" asset catalog color.
    static var brown02: SwiftUI.Color { .init(.brown02) }

    /// The "grayCaption00" asset catalog color.
    static var grayCaption00: SwiftUI.Color { .init(.grayCaption00) }

    /// The "grayCaption01" asset catalog color.
    static var grayCaption01: SwiftUI.Color { .init(.grayCaption01) }

    /// The "grayCaption02" asset catalog color.
    static var grayCaption02: SwiftUI.Color { .init(.grayCaption02) }

    /// The "grayCaption03" asset catalog color.
    static var grayCaption03: SwiftUI.Color { .init(.grayCaption03) }

    /// The "green01" asset catalog color.
    static var green01: SwiftUI.Color { .init(.green01) }

    /// The "green02" asset catalog color.
    static var green02: SwiftUI.Color { .init(.green02) }

    /// The "green03" asset catalog color.
    static var green03: SwiftUI.Color { .init(.green03) }

    /// The "greenChart01Linear01" asset catalog color.
    static var greenChart01Linear01: SwiftUI.Color { .init(.greenChart01Linear01) }

    /// The "greenChart01Linear02" asset catalog color.
    static var greenChart01Linear02: SwiftUI.Color { .init(.greenChart01Linear02) }

    /// The "greenChart02" asset catalog color.
    static var greenChart02: SwiftUI.Color { .init(.greenChart02) }

    /// The "orange01" asset catalog color.
    static var orange01: SwiftUI.Color { .init(.orange01) }

    /// The "white01" asset catalog color.
    static var white01: SwiftUI.Color { .init(.white01) }

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    /// The "black01" asset catalog color.
    static var black01: SwiftUI.Color { .init(.black01) }

    /// The "blue01" asset catalog color.
    static var blue01: SwiftUI.Color { .init(.blue01) }

    /// The "brown01" asset catalog color.
    static var brown01: SwiftUI.Color { .init(.brown01) }

    /// The "brown02" asset catalog color.
    static var brown02: SwiftUI.Color { .init(.brown02) }

    /// The "grayCaption00" asset catalog color.
    static var grayCaption00: SwiftUI.Color { .init(.grayCaption00) }

    /// The "grayCaption01" asset catalog color.
    static var grayCaption01: SwiftUI.Color { .init(.grayCaption01) }

    /// The "grayCaption02" asset catalog color.
    static var grayCaption02: SwiftUI.Color { .init(.grayCaption02) }

    /// The "grayCaption03" asset catalog color.
    static var grayCaption03: SwiftUI.Color { .init(.grayCaption03) }

    /// The "green01" asset catalog color.
    static var green01: SwiftUI.Color { .init(.green01) }

    /// The "green02" asset catalog color.
    static var green02: SwiftUI.Color { .init(.green02) }

    /// The "green03" asset catalog color.
    static var green03: SwiftUI.Color { .init(.green03) }

    /// The "greenChart01Linear01" asset catalog color.
    static var greenChart01Linear01: SwiftUI.Color { .init(.greenChart01Linear01) }

    /// The "greenChart01Linear02" asset catalog color.
    static var greenChart01Linear02: SwiftUI.Color { .init(.greenChart01Linear02) }

    /// The "greenChart02" asset catalog color.
    static var greenChart02: SwiftUI.Color { .init(.greenChart02) }

    /// The "orange01" asset catalog color.
    static var orange01: SwiftUI.Color { .init(.orange01) }

    /// The "white01" asset catalog color.
    static var white01: SwiftUI.Color { .init(.white01) }

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ColorResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 14.0, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: DeveloperToolsSupport.ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
@available(watchOS, unavailable)
extension DeveloperToolsSupport.ImageResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(UIKit)
@available(iOS 17.0, tvOS 17.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: DeveloperToolsSupport.ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

