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
            setupImage()
            nameLabel.text = model.getName()
            positionLabel.text = model.getPosition()
            tagLabel.text = model.getTag()
            dayLabel.text = model.getDay()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImage.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.layer.cornerRadius = 36
        profileImage.clipsToBounds = true
    }

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var positionLabel: UILabel!
    @IBOutlet var tagLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    
    private func setupImage() {
        if model.getImage() == nil {
            profileImage.image = UIImage(named: "Goose")
        } else {
        profileImage.fetchImage(from: model.getImage()!)
        }
    }
}
