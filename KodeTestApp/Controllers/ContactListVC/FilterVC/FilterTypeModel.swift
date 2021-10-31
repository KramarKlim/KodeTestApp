//
//  FilterTypeModel.swift
//  KodeTestApp
//
//  Created by Клим on 28.10.2021.
//

import Foundation
import UIKit

protocol FilterTypeModelProtocol {
    var contacts: SortType { get set }
    
    init(contacts: SortType)
    
    func imageButton(word: UIButton, date: UIButton)
}

class FilterTypeModel: FilterTypeModelProtocol {
    var contacts: SortType = .nothing
    
    required init(contacts: SortType) {
        self.contacts = contacts
    }
    
    func imageButton(word: UIButton, date: UIButton) {
        switch contacts {
        case .date:
            date.setImage(UIImage(named: "Circle"), for: .normal)
            word.setImage(UIImage(named: "Vector"), for: .normal)
        case .word:
            word.setImage(UIImage(named: "Circle"), for: .normal)
            date.setImage(UIImage(named: "Vector"), for: .normal)
        case .nothing:
            word.setImage(UIImage(named: "Vector"), for: .normal)
            date.setImage(UIImage(named: "Vector"), for: .normal)
        }
    }
}
