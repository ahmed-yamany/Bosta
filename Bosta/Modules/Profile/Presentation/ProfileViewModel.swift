//
//  ProfileViewModel.swift
//  Bosta
//
//  Created by Ahmed Yamany on 27/02/2025.
//

import UIKit

@MainActor
protocol ProfileViewModel {
}

@MainActor
final class ProfileViewModelImplementation: ProfileViewModel {
    let useCase: ProfileUseCase
    
    init(useCase: ProfileUseCase) {
        self.useCase = useCase
    }
}
