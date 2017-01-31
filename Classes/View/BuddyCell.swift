//
//  BuddyCell.swift
//  TestTask
//
//  Created by Amaury Vidal on 31/01/2017.
//
//

import Foundation
import UIKit

class BuddyCell: UITableViewCell {
    static let identifier = "BuddyCell"
    
    func configure(buddy: Buddy) {
        imageView?.image = UIImage(named: "\(buddy.name).jpg")
        textLabel?.text = buddy.name
        detailTextLabel?.text = buddy.lastMessage?.text
    }
}
