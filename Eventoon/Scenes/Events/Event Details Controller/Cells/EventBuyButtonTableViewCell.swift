//
//  EventBuyButtonTableViewCell.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 18/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit
import RxSwift

protocol BuyTicketCellProtocol: class {
    func goToTicketsDetails()
}

final class EventBuyButtonTableViewCell: UITableViewCell {
    @IBOutlet weak var actionButton: UIButton!
    
    weak var buyTicketActions: BuyTicketCellProtocol?
    private var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        /* Done so the actionButton tap is only subscribed once,
            and not everytime the cell is loaded, avoiding
            multiple calls*/
        super.prepareForReuse()
        self.disposeBag = DisposeBag()
    }
    
    static func newRow(event: Event, buyTicketActions: BuyTicketCellProtocol?) -> Row {
        let row = Row(identifier: String(describing: EventBuyButtonTableViewCell.self))
        
        row.setConfiguration { (cell, row, indexPath) in
            guard let cell = cell as? EventBuyButtonTableViewCell else { return }
            cell.buyTicketActions = buyTicketActions
            
            cell.actionButton.setTitle("FROM \(String.currency(from: event.price) ?? "") - GET IT!", for: .normal)
            cell.actionButton.setGradientBackground(.baseOrange, .baseRedishPink)
            cell.actionButton.roundedBorders()
            
            cell.actionButton.rx
                .tap
                .asObservable()
                .subscribe(onNext: {
                    cell.buyTicketActions?.goToTicketsDetails()
                }).disposed(by: cell.disposeBag)
            
            cell.selectionStyle = .none
        }
        
        return row
    }
}
