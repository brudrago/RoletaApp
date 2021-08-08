//
//  PaymentCell.swift
//  RoletaApp_dh
//
//  Created by Bruna Drago on 08/08/21.
//

import UIKit

class PaymentCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet var totalPriceLabel: UILabel!
    @IBOutlet var payButton: UIButton!
    
    // MARK: - Identifier
    
    static let identifier = K.paymentCell
    
    // MARK: - Action
    
    @IBAction func payButtonTapped(_ sender: UIButton) {
        
    }
    
    // MARK: - Functions
    
    func setup(orderTotal: String) {
        totalPriceLabel.text = orderTotal 
    }
}
