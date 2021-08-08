//
//  RouletteCell.swift
//  RoletaApp_dh
//
//  Created by Bruna Drago on 08/08/21.
//

import UIKit

class RouletteCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet var roletaImage: UIImageView!
    @IBOutlet var informationLabel: UILabel!
    
    // MARK: - Identifier
    
    static let identifier = "RouletteCell"
    
    // MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    // MARK: - Private Func
    
    private func setupCell() {
        self.selectionStyle = .none
    }
}
