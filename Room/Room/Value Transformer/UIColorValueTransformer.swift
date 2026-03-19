//
//  UIColorValueTransformer.swift
//  Room
//
//  Created by Hai Ng. on 19/3/26.
//

import Foundation
import UIKit

final class UIColorValueTransformer: ValueTransformer {

    // FIX: `EXC_BAD_ACCESS` tại `swift::nameForMetadata`
    // Bắt buộc phải có — khai báo kiểu output
    override class func transformedValueClass() -> AnyClass {
        NSData.self
    }

    // FIX: `EXC_BAD_ACCESS` tại `swift::nameForMetadata`
    // Bắt buộc phải có — cho phép reverse
    override class func allowsReverseTransformation() -> Bool {
        true
    }

    override func transformedValue(_ value: Any?) -> Any? {
        guard let color = value as? UIColor else { return nil }
        return try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
    }

    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        return try? NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)
    }
}

// FIX: `EXC_BAD_ACCESS` tại `swift::nameForMetadata`
// Đăng ký ngay tại đây — đảm bảo luôn chạy trước SwiftData
extension UIColorValueTransformer {
    static let transformerName = NSValueTransformerName("UIColorValueTransformer")

    static func register() {
        ValueTransformer.setValueTransformer(
            UIColorValueTransformer(),
            forName: transformerName
        )
    }
}
