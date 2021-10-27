//
//  ContactTableViewCell.swift
//  KodeTestApp
//
//  Created by Клим on 26.10.2021.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    var model: ContactModelProtocol! {
        didSet {
            profileImage.fetchImage(from: model.getImage())
            nameLabel.text = model.getName()
            positionLabel.text = model.getPosition()
            tagLabel.text = model.getTag()
            profileImage.layer.cornerRadius = 36
        }
    }

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var tagLabel: UILabel!
    
    
}
