//
//  PaymentCell.swift
//  RoletaApp_dh
//
//  Created by Bruna Drago on 08/08/21.
//

import UIKit

protocol PaymentCellDelegate {
    
    func dismissVC()
}

class PaymentCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet var totalPriceLabel: UILabel!
    @IBOutlet var payButton: UIButton!
    
    // MARK: - Identifier
    
    static let identifier = K.paymentCell
    
    var delegate: PaymentCellDelegate?
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // MARK: - Action
    
    @IBAction func payButtonTapped(_ sender: UIButton) {
        delegate?.dismissVC()
    }
    
    // MARK: - Functions
    
    func setup(orderTotal: String) {
        totalPriceLabel.text = orderTotal 
    }
    
    // MARK: - Private Functions
    
    private func setup() {
        payButton.layer.cornerRadius = 4
        self.selectionStyle = .none
    }
}
