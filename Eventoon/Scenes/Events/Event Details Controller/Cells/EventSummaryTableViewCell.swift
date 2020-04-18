//
//  EventSummaryTableViewCell.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 17/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

final class EventSummaryTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var attendanceLabel: UILabel!
    
    static func newRow(event: Event) -> Row {
        let row = Row(identifier: String(describing: EventSummaryTableViewCell.self))
        
        row.setConfiguration { (cell, row, indexPath) in
            guard let cell = cell as? EventSummaryTableViewCell else { return }
            
            cell.titleLabel.text = event.title
            cell.dateLabel.text = Date.stringFromAPIDate(intDate: event.date)
            cell.attendanceLabel.text = String(format: "%@: %i", StringConstants.attendants, event.people?.count ?? 0)
            cell.selectionStyle = .none
        }
        
        return row
    }
}
