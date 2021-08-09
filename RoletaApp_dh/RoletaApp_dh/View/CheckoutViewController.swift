//
//  CheckoutViewController.swift
//  RoletaApp_dh
//
//  Created by Bruna Drago on 08/08/21.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Private Properties
    
    private var controller = CheckoutController()
    
    // MARK: - Public Properties
    
    enum TableViewSection: Int, CaseIterable {
        case order = 0
        case payment = 1
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        controller.fetchOrder()
    }
    
    // MARK: - Private Functions
    
    private func setupUI() {
        controller.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: OrderCell.identifier, bundle: nil),
                           forCellReuseIdentifier: OrderCell.identifier)
        tableView.register(UINib(nibName: PaymentCell.identifier, bundle: nil),
                           forCellReuseIdentifier: PaymentCell.identifier)
        
        let footerView = UIView()
        footerView.backgroundColor = .black
        self.tableView.tableFooterView = footerView
    }
    
    private func getOrderCell(_ indexPath: IndexPath) -> UITableViewCell {
        let identifier = OrderCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)as? OrderCell,
              let item = controller.getItemOrder(indexPath: indexPath) else { return UITableViewCell() }
        
        cell.setup(item: item)
        
        return cell
    }
    
    private func getPaymentCell() -> UITableViewCell {
        let identifier = PaymentCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)as? PaymentCell
        else { return UITableViewCell() }
        
        cell.delegate = self
        let total = controller.getTotalValue()
        cell.setup(orderTotal: total)
        
        return cell
    }
}

// MARK: - UITableView extension

extension CheckoutViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableViewSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.numberOfRows(forSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = TableViewSection(rawValue: indexPath.section)
        else { return UITableViewCell() }
        
        switch section {
        case .order:
            return getOrderCell(indexPath)
        case .payment:
            return getPaymentCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - CheckoutControllerDelegate extension

extension CheckoutViewController: CheckoutControllerDelegate {
    
    func fetchOrderSuccess() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - PaymentCellDelegate extension

extension CheckoutViewController: PaymentCellDelegate {
    
    func goBack() {
        print("BUTTON")
        dismiss(animated: true)
    }
}
