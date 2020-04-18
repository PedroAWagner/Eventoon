//
//  DataSource.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 16/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

protocol DataSourceProtocol {
    func reloadDataSource(_ dataSource: DataSource)
}

final class DataSource: NSObject {
    
    var items: [Row] = []
    
    // MARK: - Init
    convenience init(with items: [Row]) {
        self.init()
        self.items = items
    }
}

// MARK: - DataSource Extesnion: UITableViewDelegate, UITableViewDataSource
extension DataSource: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        let identifier = item.identifier
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        item.configuration?(cell, item, indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        
        let identifier = item.identifier
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        item.didSelect?(cell, item, indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

// MARK: - DataSource Extension: UICollectionViewDelegate, UICollectionViewDataSource
extension DataSource: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        
        let identifier = item.identifier
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        item.configuration?(cell, item, indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        
        let identifier = item.identifier
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        item.configuration?(cell, item, indexPath)
    }
}
