//
//  ProfileViewModel.swift
//  Bosta
//
//  Created by Ahmed Yamany on 27/02/2025.
//

import Combine
import UIKit

@MainActor
protocol ProfileViewModel {
    var sectionsPublisher: AnyPublisher<[TableViewSection], Never> { get }
}

@MainActor
final class ProfileViewModelImplementation: ProfileViewModel {
    @Published var sections: [any TableViewSection] = []
    var sectionsPublisher: AnyPublisher<[any TableViewSection], Never> { $sections.eraseToAnyPublisher() }

    let useCase: ProfileUseCase

    init(useCase: ProfileUseCase) {
        self.useCase = useCase
        
        sections = [
            UserDetailsSection()
        ]
    }
}
