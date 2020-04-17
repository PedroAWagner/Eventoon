//
//  EventsViewController.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 16/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit

final class EventsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = EventsViewModel()
    private var dataSource: DataSource? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.delegate = self.dataSource
                self.tableView.dataSource = self.dataSource
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        viewModel.dataSourceDelegate = self
        
        viewModel.didBecomeActive()
    }
    
    // MARK: - "Setups"
    private func setupTableView() {
        tableView.register(EventsTableViewCell.self)
    }
}

// MARK: - Extension:
extension EventsViewController: DataSourceProtocol {
    func reloadDataSource(_ dataSource: DataSource) {
        self.dataSource = dataSource
    }
}
