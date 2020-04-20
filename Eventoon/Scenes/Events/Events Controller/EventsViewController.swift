//
//  EventsViewController.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 16/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CoreLocation

final class EventsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var coordinatorActions: EventsCoordinatorActions?
    
    let locationManager = CLLocationManager()
    
    private let viewModel = EventsViewModel()
    private let disposeBag = DisposeBag()
    private var dataSource: DataSource? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.delegate = self.dataSource
                self.tableView.dataSource = self.dataSource
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocation()
        setupTableView()
        setupView()
        setupViewModel()

        viewModel.didBecomeActive()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - "Setups"
    private func setupLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    private func setupViewModel() {
        viewModel.dataSourceStream
            .asObservable()
            .subscribe(onNext: { [weak self] dataSource in
                self?.dataSource = dataSource
            }).disposed(by: disposeBag)
        
        viewModel.showEventsDetailStream
            .asObservable()
            .subscribe(onNext: { [coordinatorActions] event in
                coordinatorActions?.showEventsDetail(eventId: event.id)
            }).disposed(by: disposeBag)
        
        viewModel.createUserActionStream
            .asObservable()
            .subscribe(onNext: { [coordinatorActions] in
                coordinatorActions?.createUser()
            }).disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        tableView.register(EventsTableViewCell.self)
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        tableView.refreshControl = refreshControl
        tableView.refreshControl?.rx
            .controlEvent(.valueChanged)
            .subscribe(onNext: { [weak self] in
                self?.viewModel.refresh()
            }).disposed(by: disposeBag)
    }
    
    private func setupView() {
        view.backgroundColor = .baseDarkGray
        title = StringConstants.events
    }
}

// MARK: - Extension: CLLocationManagerDelegate
extension EventsViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let _ = manager.location?.coordinate else { return }
    }
}
