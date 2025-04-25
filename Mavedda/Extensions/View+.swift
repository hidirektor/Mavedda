//
//  View+.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import SwiftUI

extension View {
    func printToConsole<T>(_ message: T) -> some View {
        #if DEBUG
        DispatchQueue.main.async {
            print(message)
        }
        #endif
        return self
    }
}
