//
//  CustomFriendTableViewCell.swift
//  FindYourFriends
//
//  Created by Giuseppe Diciolla on 30/09/2020.
//

import Foundation
import UIKit

class CustomFriendTableViewCell: UITableViewCell {
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendDistanceToYou: UILabel!
    @IBOutlet weak var navigateToFriendButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.navigateToFriendButton.layer.cornerRadius = navigateToFriendButton.bounds.height/2
    }
}
