//
//  EventsTableViewCell.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 16/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

final class EventsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    static func newRow(event: Event) -> Row {
        let row = Row(identifier: String(describing: EventsTableViewCell.self))
        
        row.setConfiguration { (cell, row, indexPath) in
            guard let cell = cell as? EventsTableViewCell else { return }
            cell.titleLabel.text = event.title
        }
        
        return row
    }
}
