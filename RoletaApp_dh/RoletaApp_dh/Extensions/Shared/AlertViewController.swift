//
//  AlertViewController.swift
//  RoletaApp_dh
//
//  Created by Bruna Drago on 09/08/21.
//

import UIKit

class AlertViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet var alertContainer: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var alertImage: UIImageView!
    @IBOutlet var actionButton: UIButton!
    
    // MARK: - Public Properties
    
    var alertTitle = String()
    
    var alertMessage = String()
    
    var buttonTitle = String()
    
    var buttonAction: (()-> Void)?
    
    // MARK: - Inits
    
    init(title: String, message: String, buttonTitle: String, buttonAction:(()-> Void)?) {
        super.init(nibName: "AlertViewController", bundle: nil)
        self.alertTitle = title
        self.alertMessage = message
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAlert()
    }
    
    // MARK: - Action

    @IBAction func ActionButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
        
        buttonAction?()
    }
    
    // MARK: - Private Functions
    
    private func setupAlert() {
        titleLabel.text = alertTitle
        messageLabel.text = alertMessage
        actionButton.setTitle(buttonTitle, for: .normal)
    }
    
    private func setupUI() {
        actionButton.layer.cornerRadius = 8
    }
}
