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

extension TableViewSectionDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
}

typealias TableViewSection = TableViewSectionDelegate & TableViewSectionDataSource
