//
//  AlbumsTableViewSection.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//

import UIKit

import UIKit

/// A table view section responsible for displaying a list of albums.
///
/// This section conforms to `TableViewSection`, making it a pluggable and interchangeable
/// part of the table view using the **Strategy Pattern**.

class AlbumsTableViewSection: TableViewSection {
    typealias CellType = AlbumTableViewCell

    let albums: [AlbumEntity]

    /// Closure called when an album is selected.
    ///
    /// This allows the section to communicate user interactions
    /// back to the view model.
    let onSelectAlbum: (AlbumEntity) -> Void

    init(albums: [AlbumEntity], onSelectAlbum: @escaping (AlbumEntity) -> Void) {
        self.albums = albums
        self.onSelectAlbum = onSelectAlbum
    }

    func registerCell(in tableView: UITableView) {
        tableView.registerFromNib(CellType.self)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(CellType.self, for: indexPath) else {
            debugPrint("Could not dequeue cell")
            return UITableViewCell()
        }

        let album = albums[indexPath.row]
        cell.update(with: album)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let album = albums[safe: indexPath.row] else {
            debugPrint("Could not find album at index \(indexPath.row)")
            return
        }
        tableView.deselectRow(at: indexPath, animated: true)
        onSelectAlbum(album)
    }
}
