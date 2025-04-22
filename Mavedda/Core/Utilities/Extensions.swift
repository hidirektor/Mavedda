//
//  Extensions.swift
//  Finance
//
//  Created by Halil İbrahim Direktör on 2.04.2025.
//

import SwiftUI

extension Font {
    
    struct SF {
        static func regular(size: CGFloat) -> Font {
            .custom("SF-Pro-Display-Regular", size: size)
        }
        
        static func light(size: CGFloat) -> Font {
            .custom("SF-Pro-Display-Light", size: size)
        }
        
        static func medium(size: CGFloat) -> Font {
            .custom("SF-Pro-Display-Medium", size: size)
        }
        
        static func bold(size: CGFloat) -> Font {
            .custom("SF-Pro-Display-Bold", size: size)
        }
    }
}

extension Double {
    func formattedCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        if let formattedString = formatter.string(from: NSNumber(value: self)) {
            return formattedString
        } else {
            return "\(self)"
        }
    }
}
