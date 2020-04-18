//
//  EventDetailsViewController.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 17/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class EventDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var coordinatorActions: EventsCoordinatorActions?
    
    private let viewModel: EventDetailsViewModel
    private let disposeBag = DisposeBag()
    private var dataSource: DataSource? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.delegate = self.dataSource
                self.tableView.dataSource = self.dataSource
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Init
    init(viewModel: EventDetailsViewModel) {
        self.viewModel = viewModel
        self.coordinatorActions = nil
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = EventDetailsViewModel(eventId: nil)
        self.coordinatorActions = nil
        super.init(coder: coder)
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupViewModel()
        setupTableView()
        
        viewModel.didBecomeActive()
    }
    
    // MARK: - "Setups"
    private func setupView() {
        view.backgroundColor = .baseDarkGray
        title = StringConstants.eventDetails
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(assetIdentifier: .leftArrow), style: .plain, target: self, action: nil)
        backButton.rx.tap
            .asObservable()
            .subscribe(onNext: { [weak self] in
                self?.coordinatorActions?.popViewController()
            }).disposed(by: disposeBag)
        
        let shareButton = UIBarButtonItem(image: UIImage(assetIdentifier: .share), style: .plain, target: self, action: nil)
        shareButton.rx.tap
            .asObservable()
            .subscribe(onNext: { [weak self] in
                self?.share()
            }).disposed(by: disposeBag)
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = shareButton
    }
    
    private func setupViewModel() {
        viewModel.dataSourceStream
            .asObservable()
            .subscribe(onNext: { [weak self] dataSource in
                self?.dataSource = dataSource
            }).disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        self.tableView.register(
            EventImageTableViewCell.self,
            EventSummaryTableViewCell.self,
            EventAboutTableViewCell.self,
            EventLocationTableViewCell.self,
            EventBuyButtonTableViewCell.self
        )
    }
    
    // MARK: - Actions
    private func share() {
        let shareText = StringConstants.checkoutEvent.replacingOccurrences(of: "{eventName}", with: viewModel.event?.title ?? "")

        let textToShare = [shareText]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view

        present(activityViewController, animated: true, completion: nil)
    }
}
