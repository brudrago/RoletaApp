//
//  OrderCell.swift
//  RoletaApp_dh
//
//  Created by Bruna Drago on 08/08/21.
//

import UIKit

class OrderCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var itemName: UILabel!
    @IBOutlet var itemPrice: UILabel!
    @IBOutlet var itemQuantity: UILabel!
    
    
    // MARK: - Identifier
    
    static let identifier = K.orderCell

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    // MARK: - Functions
    
    func setupList(item: ItemList) {
        itemName.text = item.name
        itemPrice.text = String(format: "%.2f", item.price)
        itemQuantity.isHidden = true
    }
    
    func setup(item: ItemOrder) {
        itemName.text = item.name
        itemPrice.text = String (item.price)
        itemQuantity.text = String(item.quantity)
        itemImage.image = setImage(items: item)
    }
    
    private func setImage(items: ItemOrder) -> UIImage? {
        let drink = Images.imageBeer
        let food = Images.imageFood
        
        return items.productType == "BEBIDA" ? drink : food
    }
    
    private func setupCell() {
        self.selectionStyle = .none
    }
}
