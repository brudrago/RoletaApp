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
    
    static let identifier = "UserCell"
    
    // MARK: - Functions
    
    //    func setupCell(user: User) {
    //        self.avatarImage.image = user.imageName
    //        self.nameLabel.text = user.name
    //    }
    
}
