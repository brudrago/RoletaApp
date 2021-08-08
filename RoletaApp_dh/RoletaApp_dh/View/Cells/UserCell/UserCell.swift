//
//  UserCell.swift
//  RoletaApp_dh
//
//  Created by Bruna Drago on 08/08/21.
//

import UIKit

class UserCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
    // MARK: - Identifier
    
    static let identifier = K.userCell
    
    // MARK: - Functions
    
    func setupCell(user: User) {
        self.avatarImage.image = user.userImage
        self.nameLabel.text = user.name
    }
}
