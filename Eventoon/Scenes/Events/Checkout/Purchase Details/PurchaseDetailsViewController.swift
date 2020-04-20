//
//  PurchaseDetailsViewController.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 18/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit
import RxSwift
import CoreLocation

final class PurchaseDetailsViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var cuponView: UIView!
    @IBOutlet weak var cuponTextField: UITextField!
    @IBOutlet weak var paymentButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var paymentButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var gradientViewTopConstraint: NSLayoutConstraint!
    
    var coordinatorActions: CheckoutCoordinatorActions?
    
    private let paymentButtonBottomConstraintValue: CGFloat = 15
    private var appliedCuponCode: Bool = false {
        didSet {
            if appliedCuponCode {
                applyButton.isEnabled = false
                cuponTextField.isEnabled = false
            }
        }
    }
    
    private let viewModel: PurchaseDetailsViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    init(viewModel: PurchaseDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = PurchaseDetailsViewModel(event: nil)
        super.init(coder: coder)
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupViewModel()
        setupNotifications()
        
        viewModel.didBecomeActive()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientView.setGradientBackground(.baseOrange, .baseRedishPink)
    }
    
    // MARK: - "Setups"
    private func setupViewModel() {
        viewModel.dataSourceStream
            .asObservable()
            .subscribe(onNext: { [weak self] event in
                self?.populateView(with: event)
            }).disposed(by: disposeBag)
        
        viewModel.cuponStream
            .asObservable()
            .subscribe(onNext: { [weak self, cuponView] success, discount in
                guard success else {
                    cuponView?.shakeAnimation()
                    return
                }
                cuponView?.pulseAnimation()
                self?.repopulatePrice(with: discount)
                self?.dismissKeyboard()
            }).disposed(by: disposeBag)
        
        viewModel.paymentProcessingStream
            .asObservable()
            .subscribe(onNext: { [weak self, coordinatorActions] success in
                guard success else {
                    DispatchQueue.main.async {
                        self?.showAlert(ErrorConstants.paymentProcessingError, title: ErrorConstants.attentionTitle)
                    }
                    return
                }
                DispatchQueue.main.async {
                    self?.showAlert(StringConstants.successMessage, title: StringConstants.success, okHandler: { _ in
                        coordinatorActions?.goBackToEventList()
                    })
                }
            }).disposed(by: disposeBag)
    }
    
    private func setupView() {
        cuponView.cornerOn(.all, radius: 10)
        cuponView.addBorder(borderWidth: 1, borderColor: .lightGray)
        
        paymentButton.roundedCorners()
        paymentButton.setGradientBackground(.baseOrange, .baseRedishPink)
        paymentButton.rx.tap
            .subscribe(onNext: { [viewModel] in
                viewModel.finilizePurchase()
            }).disposed(by: disposeBag)
        
        applyButton.isEnabled = false
        applyButton.rx.tap
            .subscribe(onNext: {
                self.applyCupon()
            }).disposed(by: disposeBag)
        
        backButton.rx.tap
            .subscribe(onNext: { [coordinatorActions] in
                coordinatorActions?.popViewController()
            }).disposed(by: disposeBag)
        
        cuponTextField.rx.controlEvent(.editingChanged)
            .asObservable()
            .subscribe(onNext: { [cuponTextField] in
                self.textDidChange(cuponTextField ?? UITextField())
            }).disposed(by: disposeBag)
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Populating methods
    private func populateView(with event: Event) {
        wrapperView.cornerOn(.all, radius: 10)
        priceView.cornerOn(.bottom, radius: 10)
        
        titleLabel.text = event.title
        dateLabel.text = Date.stringFromAPIDate(intDate: event.date)
        priceLabel.text = String.currency(from: event.price)
        setLocations(from: event)
    }
    
    private func setLocations(from event: Event) {
        let eventCoordinates = CLLocation(latitude: event.latitude, longitude: event.longitude)
        
        CLLocation.getCompleteAddressFromCoordinates(eventCoordinates) { [weak self] address in
            DispatchQueue.main.async {
                self?.addressLabel.text = address
                self?.view.setNeedsLayout()
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    // MARK: - Actions
    @IBAction private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            let animationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0.5
            self.paymentButtonBottomConstraint.constant = keyboardSize.height - view.safeAreaInsets.bottom + paymentButtonBottomConstraintValue
            
            let overlappingYValue = (paymentButton.frame.minY - keyboardSize.height - view.safeAreaInsets.bottom + paymentButtonBottomConstraintValue) - cuponView.frame.maxY
            
            if overlappingYValue < 0 {
                /* This '40' is the '20' max distance between the button and
                    the view, and '20' from the status bar*/
                gradientViewTopConstraint.constant = overlappingYValue - 40
            }
            
            UIView.animate(withDuration: animationDuration) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction private func keyboardWillHide(notification: NSNotification) {
        let animationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0.5

        self.paymentButtonBottomConstraint.constant = self.paymentButtonBottomConstraintValue
        gradientViewTopConstraint.constant = 0
        
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction private func dismissKeyboard() {
        self.cuponTextField.resignFirstResponder()
    }
    
    private func applyCupon() {
        guard let cuponCode = cuponTextField.text else {
            return
        }
        viewModel.applyCupon(code: cuponCode)
    }
    
    private func repopulatePrice(with discount: Int?) {
        guard let discount = discount,
            let currentPrice = priceLabel.text else {
                return
        }
        let discountedPrice = String.setDiscount(discount, to: currentPrice)
        priceLabel.text = discountedPrice
        priceLabel.pulseAnimation()
        appliedCuponCode = true
    }
    
    private func textDidChange(_ sender: UITextField) {
        guard let text = sender.text else { return }
        guard !appliedCuponCode else {
            return
        }
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            applyButton.isEnabled = false
            return
        }
        applyButton.isEnabled = true
    }
}
