//
//  EventAboutTableViewCell.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 18/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

final class EventAboutTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    static func newRow(event: Event) -> Row {
        let row = Row(identifier: String(describing: EventAboutTableViewCell.self))
        
        row.setConfiguration { cell, row, indexPath in
            guard let cell = cell as? EventAboutTableViewCell else { return }
            
            cell.selectionStyle = .none
            cell.descriptionLabel.text = event.description
        }
        
        return row
    }
}
