//
//  ProfileViewModelTests.swift
//  BostaTests
//
//  Created by Ahmed Yamany on 28/02/2025.
//

@testable import Bosta
import Combine
import XCTest

final class ProfileViewModelTests: XCTestCase {
    var cancellables: Set<AnyCancellable>!
    var coordinator: ProfileCoordinatorMock!
    var useCase: ProfileUseCaseMock!
    var sut: ProfileViewModel!

    @MainActor
    override func setUp() {
        cancellables = []
        coordinator = ProfileCoordinatorMock()
        useCase = ProfileUseCaseMock()
        sut = ProfileViewModelImplementation(useCase: useCase, coordinator: coordinator)
    }

    override func tearDown() {
        cancellables = nil
        coordinator = nil
        useCase = nil
        sut = nil
    }

    func test_featchUserProfile_success_updatesSections() async {
        // Arrange
        let user = UserEntity(name: "Ahmed", userName: "@ahmed", email: "ahmed@g.com", address: "Giza")
        let albums = [
            AlbumEntity(id: 1, title: "Album 1"),
            AlbumEntity(id: 2, title: "Album 2"),
        ]
        let profile = ProfileEntity(user: user, albums: albums)
        useCase.fetchProfileResult = .success(profile)

        let expectation = XCTestExpectation(description: "Sections updated")

        // Act
        await sut.sectionsPublisher
            .dropFirst() // Drop initial empty state
            .sink { sections in
                // Assert
                XCTAssertEqual(sections.count, 2, "Expected 2 sections: user and albums")

                // Validate UserDetailsSection
                if let userDetailsSection = sections.first as? UserDetailsSection {
                    XCTAssertEqual(userDetailsSection.user.name, "Ahmed")
                } else {
                    XCTFail("First section should be UserDetailsSection")
                }

                // Validate AlbumsTableViewSection
                if let albumsSection = sections.last as? AlbumsTableViewSection {
                    XCTAssertEqual(albumsSection.albums.count, 2)
                } else {
                    XCTFail("Second section should be AlbumsTableViewSection")
                }

                expectation.fulfill()
            }
            .store(in: &cancellables)

        await sut.featchUserProfile()

        // Wait for async updates
        await fulfillment(of: [expectation], timeout: 2.0)
    }

    func test_albumSelection_navigatesToAlbum() async {
        // Arrange
        let albums = [
            AlbumEntity(id: 1, title: "Album 1"),
        ]
        let user = UserEntity(name: "Ahmed", userName: "@ahmed", email: "ahmed@g.com", address: "Giza")

        let profile = ProfileEntity(user: user, albums: albums)
        useCase.fetchProfileResult = .success(profile)
        let expectation = XCTestExpectation(description: "Sections updated")

        // Act
        await sut.featchUserProfile()

        // Assert
        await sut.sectionsPublisher
            .dropFirst() // Drop initial empty state
            .sink { sections in

                // Act
                if let albumsSection = sections.compactMap({ $0 as? AlbumsTableViewSection }).first {
                    albumsSection.onSelectAlbum(albums[0])
                } else {
                    XCTFail("AlbumsTableViewSection should exist after fetching profile")
                }
                expectation.fulfill()
            }.store(in: &cancellables)

        await fulfillment(of: [expectation], timeout: 2.0)
        XCTAssertEqual(coordinator.didNavigateToAlbum?.id, 1, "Coordinator should receive navigation event for album with id 1")
    }
}
