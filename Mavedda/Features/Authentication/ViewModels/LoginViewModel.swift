//
//  LoginViewModel.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 22.04.2025.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String?
    @Published var isLoading = false

    private let authService: AuthService
    private var cancellables = Set<AnyCancellable>()
    let onLogin: () -> Void

    init(authService: AuthService, onLogin: @escaping () -> Void) {
        self.authService = authService
        self.onLogin = onLogin
    }

    func login() {
        isLoading = true
        authService.login(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion {
                case .finished:
                    self?.onLogin()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
    }
}
