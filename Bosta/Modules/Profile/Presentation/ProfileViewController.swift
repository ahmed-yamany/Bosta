//
//  ProfileViewController.swift
//  Bosta
//
//  Created by Ahmed Yamany on 27/02/2025.
//

import Combine
import UIKit

class ProfileViewController: UIViewController {
    let tableView = UITableView()
    var sections: [TableViewSection] = []
    private var cancellable: Set<AnyCancellable> = []

    let viewModel: ProfileViewModel

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view = tableView
        configureTableView()
        bindTableViewSections()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func bindTableViewSections() {
        viewModel
            .sectionsPublisher
            .sink { [weak self] sections in
                self?.sections = sections
                self?.registerTableViewCells()
                self?.tableView.reloadData()
            }
            .store(in: &cancellable)
    }

    private func registerTableViewCells() {
        for section in sections {
            section.registerCell(in: tableView)
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].tableView(tableView, numberOfRowsInSection: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        sections[indexPath.section].tableView(tableView, cellForRowAt: indexPath)
    }
}

extension ProfileViewController: UITableViewDelegate {
}
