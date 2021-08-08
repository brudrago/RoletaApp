//
//  SortViewController.swift
//  RoletaApp_dh
//
//  Created by Bruna Drago on 08/08/21.
//

import UIKit

class SortViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var sortButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Private Properties
    private let controller = SortController()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
       // setupButton()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        self.controller.delegate = self
        
        nameTextField.delegate = self
        nameTextField.placeholder = K.placeholder
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: RouletteCell.identifier, bundle: nil),
                           forCellReuseIdentifier: RouletteCell.identifier)
        tableView.register(UINib(nibName: UserCell.identifier, bundle: nil),
                           forCellReuseIdentifier: UserCell.identifier)
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
}

// MARK: - SortControllerDelegate extension

extension SortViewController: SortControllerDelegate {
    func showSortedUser(name: String) {
        showMessageWithAction(
            title: name, message: K.alertMessage, actionTitle: "OK") { action in
            self.controller.proceedToCheckout()
            self.tableView.reloadData()
        }
    }
    
    func removeNotSortedUser(indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .left)
    }
}
