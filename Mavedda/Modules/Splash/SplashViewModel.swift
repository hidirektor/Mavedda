//
//  SplashViewModel.swift
//  Mavedda
//
//  Created by Halil İbrahim Direktör on 25.04.2025.
//

import Foundation
import SwiftUI

class SplashViewModel: BaseViewModel {
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore = false
    private let appCoordinator: AppCoordinator

      init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }

    func navigateToNextScreen() {
         if !hasLaunchedBefore {
            appCoordinator.show(.onboarding)
        } else {
            appCoordinator.show(.authSelection)
        }
        hasLaunchedBefore = true
    }
}
