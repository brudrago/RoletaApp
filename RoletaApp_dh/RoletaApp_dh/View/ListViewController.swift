//
//  ListViewController.swift
//  RoletaApp_dh
//
//  Created by Bruna Drago on 08/08/21.
//

import UIKit

class ListViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet var tableView: UITableView!
    
    private var controller = ListController()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        controller.fetchList()
    }
    
    private func setupUI() {
        controller.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: OrderCell.identifier, bundle: nil),
                           forCellReuseIdentifier: OrderCell.identifier)
        
        let footerView = UIView()
        footerView.backgroundColor = .black
        self.tableView.tableFooterView = footerView
    }
    
    private func getOrderCell(_ indexPath: IndexPath) -> UITableViewCell {
        let identifier = OrderCell.identifier
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier)as? OrderCell,
              let item = controller.getItemOrder(indexPath: indexPath) else { return UITableViewCell() }
        
        cell.setupList(item: item)

        return cell
    }
    
}

// MARK: - UITableView extension

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getOrderCell(indexPath)
    }
}

// MARK: - ListControllerDelegate extension

extension ListViewController: ListControllerDelegate {
    
    func fetchListSucceed() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
