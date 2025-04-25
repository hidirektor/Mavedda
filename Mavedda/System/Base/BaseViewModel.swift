//
//  BaseViewModel.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import Foundation
import Combine

class BaseViewModel: ObservableObject {
    // Ortak view model özellikleri ve fonksiyonları
    @Published var errorMessage: String?
    var cancellables = Set<AnyCancellable>()

    deinit {
        cancellables.forEach { $0.cancel() }
    }
}
