//
//  ItemCell.swift
//  GymLogger
//
//  Created by Prasidha Timsina on 11/4/20.
//

import Foundation

import UIKit
class ItemCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var exerciseGroupLabel: UILabel!
    @IBOutlet var currentWeightLabel: UILabel!
    
    override func awakeFromNib() {
     super.awakeFromNib()
     nameLabel.adjustsFontForContentSizeCategory = true
     exerciseGroupLabel.adjustsFontForContentSizeCategory = true
     currentWeightLabel.adjustsFontForContentSizeCategory = true
    }
}


