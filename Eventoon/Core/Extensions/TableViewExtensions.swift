//
//  TableViewExtensions.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 16/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

extension UITableView {
    func register(_ cell: AnyClass) {
        register(UINib(nibName: String(describing: cell.self), bundle: nil), forCellReuseIdentifier: String(describing: cell.self))
    }
    
    func register(_ cells: AnyClass ...) {
        cells.forEach(register)
    }
}
