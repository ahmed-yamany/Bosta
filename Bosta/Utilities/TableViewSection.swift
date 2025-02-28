//
//  TableViewSection.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//

import UIKit

protocol TableViewSectionDataSource {
    func registerCell(in tableView: UITableView)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
}

protocol TableViewSectionDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
}

/// Provides a default no-op implementation for `didSelectRowAt`
/// This allows conforming types to omit selection handling if not needed.
extension TableViewSectionDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}

/// A typealias combining `TableViewSectionDataSource` and `TableViewSectionDelegate`.
///
/// This allows you to define a **complete section strategy**, where both:
/// - Data (how many rows, how cells are built)
/// - Behavior (how user interactions are handled)
///
/// are bundled into a single object.
///
/// ### Example
/// You could have:
/// - `UserDetailsSection`: Shows user profile information
/// - `AlbumsSection`: Shows user albums
///
/// Each section can be swapped in/out, fully respecting the **Strategy Design Pattern**.
typealias TableViewSection = TableViewSectionDelegate & TableViewSectionDataSource
