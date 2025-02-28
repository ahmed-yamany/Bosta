//
//  ProfileViewController.swift
//  Bosta
//
//  Created by Ahmed Yamany on 27/02/2025.
//

import Combine
import UIKit

class ProfileViewController: UIViewController {
    // MARK: - subviews

    let tableView = UITableView()

    // MARK: Properties

    var sections: [TableViewSection] = []
    private var cancellable: Set<AnyCancellable> = []

    // MARK: - INIT

    let viewModel: ProfileViewModel

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view = tableView
        configureTableView()
        bindTableViewSections()
        viewModel.featchUserProfile()
    }

    // MARK: - Private Methods

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

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[safe: section]?.tableView(tableView, numberOfRowsInSection: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        sections[safe: indexPath.section]?.tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        sections[safe: indexPath.section]?.tableView(tableView, heightForRowAt: indexPath) ?? tableView.estimatedRowHeight
    }
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sections[safe: indexPath.section]?.tableView(tableView, didSelectRowAt: indexPath)
    }
}
