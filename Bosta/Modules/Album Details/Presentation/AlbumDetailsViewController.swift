//
//  AlbumDetailsViewController.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//

import Combine
import UIKit

class AlbumDetailsViewController: UIViewController {
    let collectinView = UICollectionView(frame: .zero, collectionViewLayout: .init())

    var sections: [CollectionViewSection] = []
    private var cancellable: Set<AnyCancellable> = []

    let viewModel: AlbumDetailsViewModel

    init(viewModel: AlbumDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = collectinView
        configureCollectionView()
        bindCollectionViewSections()
    }

    private func configureCollectionView() {
        collectinView.delegate = self
        collectinView.dataSource = self
    }

    private func bindCollectionViewSections() {
        viewModel.sectionsPublisher.sink { [weak self] sections in
            self?.sections = sections
            self?.registerCollectionViewCells()
            self?.setCollectionViewLayout()
            self?.collectinView.reloadData()
        }.store(in: &cancellable)
    }

    private func registerCollectionViewCells() {
        for section in sections {
            section.registerCell(in: collectinView)
        }
    }

    private func setCollectionViewLayout() {
        let provider = createCollectionViewSectionProvider()
        collectinView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: provider)
    }

    private func createCollectionViewSectionProvider() -> UICollectionViewCompositionalLayoutSectionProvider {
        { [weak self] sectionIndex, layoutEnvironment in
            guard let self else { return nil }
            guard let section = sections[safe: sectionIndex] else { return nil }
            return section.sectionLayout(at: sectionIndex, layoutEnvironment: layoutEnvironment)
        }
    }
}

extension AlbumDetailsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let collectionSection = sections[safe: section] else {
            debugPrint("Section not found")
            return 0
        }

        return collectionSection.collectionView(collectionView, numberOfItemsInSection: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionSection = sections[safe: indexPath.section] else {
            debugPrint("Section not found")
            return UICollectionViewCell()
        }
        return collectionSection.collectionView(collectionView, cellForItemAt: indexPath)
    }
}

extension AlbumDetailsViewController: UICollectionViewDelegate {
}
