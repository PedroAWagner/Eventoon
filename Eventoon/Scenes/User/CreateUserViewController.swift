//
//  CreateUserViewController.swift
//  Eventoon
//
//  Created by Pedro Arenhardt Wagner  on 19/04/20.
//  Copyright © 2020 Pedro Arenhardt Wagner . All rights reserved.
//

import UIKit
import RxSwift

final class CreateUserViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var createButton: UIButton!
    
    @IBOutlet weak var buttonLeadingConstranint: NSLayoutConstraint!
    @IBOutlet weak var buttonTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttomBottomConstraint: NSLayoutConstraint!
    
    private let viewModel: CreateUserViewModel
    private let buttonConstraintConstans: CGFloat = 20
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    init(viewModel: CreateUserViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = CreateUserViewModel(coordinatorActions: nil)
        super.init(coder: coder)
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupNotifications()
        setupViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        nameView.setGradientBackground(.baseOrange, .baseRedishPink)
        emailView.setGradientBackground(.baseOrange, .baseRedishPink)
        createButton.setGradientBackground(.baseOrange, .baseRedishPink)
    }
    
    // MARK: - "Setups"
    private func setupView() {
        nameView.cornerOn(.all, radius: 10)
        emailView.cornerOn(.all, radius: 10)
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        
        createButton.roundedCorners()
        createButton.rx.tap
            .subscribe(onNext: { [viewModel, nameTextField, emailTextField] in
                viewModel.createUser(name: nameTextField?.text, email: emailTextField?.text)
            }).disposed(by: disposeBag)
    }
    
    private func setupViewModel() {
        viewModel.userCreationStream
            .asObservable()
            .subscribe(onNext: { [weak self] userCreationError in
                self?.showAlert(userCreationError, title: ErrorConstants.attentionTitle)
            }).disposed(by: disposeBag)
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    
    // MARK: - Actions
    @IBAction private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            buttomBottomConstraint.constant = keyboardSize.height - view.safeAreaInsets.bottom
            buttonLeadingConstranint.constant = 0
            buttonTrailingConstraint.constant = 0
            
            let animationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0.5
            
            UIView.animate(withDuration: animationDuration) {
                self.createButton.flatCorners()
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction private func keyboardWillHide(notification: NSNotification) {
        let animationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0.5
        
        self.buttomBottomConstraint.constant = self.buttonConstraintConstans
        self.buttonLeadingConstranint.constant = self.buttonConstraintConstans
        self.buttonTrailingConstraint.constant = self.buttonConstraintConstans
        
        UIView.animate(withDuration: animationDuration) {
            self.createButton.roundedCorners()
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction private func dismissKeyboard() {
        self.nameTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
    }
}

// MARK: - Extension: UITextFieldDelegate
extension CreateUserViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField == emailTextField else {
            emailTextField.becomeFirstResponder()
            return false
        }
        emailTextField.resignFirstResponder()
        return true
    }
}
