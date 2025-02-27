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
}

protocol TableViewSectionDelegate {
}

typealias TableViewSection = TableViewSectionDelegate & TableViewSectionDataSource
