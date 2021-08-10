//
//  SortViewController.swift
//  RoletaApp_dh
//
//  Created by Bruna Drago on 08/08/21.
//

import UIKit
import Lottie

class SortViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var sortButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var animationView: UIView!
    
    // MARK: - Private Properties
    
    private let controller = SortController()
    private let animationViewLottie = AnimationView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButton()
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBar()
        setupLottie()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        controller.delegate = self
        
        nameTextField.delegate = self
        nameTextField.placeholder = K.placeholder
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: RouletteCell.identifier, bundle: nil),
                           forCellReuseIdentifier: RouletteCell.identifier)
        tableView.register(UINib(nibName: UserCell.identifier, bundle: nil),
                           forCellReuseIdentifier: UserCell.identifier)
        
        let footerView = UIView()
        footerView.backgroundColor = .black
        self.tableView.tableFooterView = footerView
    }
    
    private func setupLottie() {
        let animation = Animation.named("credit-card")
        
        animationViewLottie.animation = animation
        animationViewLottie.contentMode = .scaleAspectFit
        animationView.addSubview(animationViewLottie)
        
        animationViewLottie.translatesAutoresizingMaskIntoConstraints = false
        animationViewLottie.topAnchor.constraint(equalTo: animationView.layoutMarginsGuide.topAnchor).isActive = true
        animationViewLottie.leadingAnchor.constraint(equalTo: animationView.leadingAnchor).isActive = true
        
        animationViewLottie.trailingAnchor.constraint(equalTo: animationView.trailingAnchor).isActive = true
        animationViewLottie.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)
        
        animationViewLottie.play(fromFrame: 0, toFrame: 200, loopMode: .loop)
    }
    
    private func setNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private  func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    private func setupButton() {
        let isEnabled = controller.isButtonEnabled()
        sortButton.isEnabled = isEnabled
        sortButton.backgroundColor = setButtonBackgroundColor(isOn: isEnabled)
    }
    
    private func setButtonBackgroundColor(isOn: Bool) -> UIColor {
        return isOn ?  .systemBlue : .systemGray2
    }
    
    private func getRouletteCell() -> UITableViewCell {
        let identifier = RouletteCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? RouletteCell else { return UITableViewCell() }
        return cell
    }
    
    private func getUserCell(index: Int) -> UITableViewCell {
        let identifier = UserCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)
                as? UserCell else { return UITableViewCell() }
        
        let user = controller.getUser(index: index)
        
        cell.setupCell(user: user)
        
        return cell
    }
    
    private func proceedToCheckout() {
        let identifier = K.checkoutVCIdentifier
        guard let checkoutViewController = self.storyboard?.instantiateViewController(identifier: identifier)
                as? CheckoutViewController else { return }
        checkoutViewController.modalPresentationStyle = .fullScreen
        present(checkoutViewController, animated: true) {
            self.controller.setCanSelectuser(false)
            self.controller.removeAllUsers()
            self.tableView.reloadData()
        }
    }
    
    @IBAction func sortButtonTapped(_ sender: UIButton) {
        controller.sortUserToPay()
        controller.setCanSelectuser(true)
    }
}

// MARK: - UITextFieldDelegate extension

extension SortViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        guard let nameUser = nameTextField.text else { return false }
        controller.addUser(nameUser)
        nameTextField.text?.removeAll()
        setupButton()
        tableView.reloadData()
        
        return true
    }
}

// MARK: - UITableView extension

extension SortViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return controller.isEmpty() ? getRouletteCell() : getUserCell(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        controller.checkUserSorted(indexPath: indexPath)
    }
}

// MARK: - SortControllerDelegate extension

extension SortViewController: SortControllerDelegate {
    
    func removeNotSortedUser(indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .left)
    }
    
    func showSortedUser(name: String) {
        showCustomAlertWithActionOnMainThread(title: name, message: K.alertMessage, buttonTitle: K.buttonTitle) {
            self.proceedToCheckout()
        }
    }
}
