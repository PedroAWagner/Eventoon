//
//  EventImageTableViewCell.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 17/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

final class EventImageTableViewCell: UITableViewCell {
    @IBOutlet weak var eventImageView: UIImageView!
    
    static func newRow(imageUrl: String) -> Row {
        let row = Row(identifier: String(describing: EventImageTableViewCell.self))
        
        row.setConfiguration { (cell, row, indexPath) in
            guard let cell = cell as? EventImageTableViewCell else { return }
            
            cell.eventImageView.downloadImage(url: imageUrl)
            cell.selectionStyle = .none
        }
        
        return row
    }
}
