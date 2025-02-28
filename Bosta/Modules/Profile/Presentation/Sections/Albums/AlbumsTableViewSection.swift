//
//  AlbumsTableViewSection.swift
//  Bosta
//
//  Created by Ahmed Yamany on 28/02/2025.
//

import UIKit

class AlbumsTableViewSection: TableViewSection {
    typealias CellType = AlbumTableViewCell

    let albums: [AlbumEntity]
    let onSelectAlbum: (AlbumEntity) -> Void
    
    init(albums: [AlbumEntity], onSelectAlbum: @escaping (AlbumEntity) -> Void) {
        self.albums = albums
        self.onSelectAlbum = onSelectAlbum
    }

    func registerCell(in tableView: UITableView) {
        tableView.registerFromNib(CellType.self)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        albums.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(CellType.self, for: indexPath) else {
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
