//
//  SortedListCollectionViewCell.swift
//  KodeTestApp
//
//  Created by Клим on 27.10.2021.
//

import UIKit

class SortedListCollectionViewCell: UICollectionViewCell {
    
    var model: SortedListModelProtocol! {
        didSet {
            nameLabel.text = model.name
            
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.textColor = .lightGray
        colorView.backgroundColor = .white
    }
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var colorView: UIView!
    
}
