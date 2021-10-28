//
//  FilterTypeModel.swift
//  KodeTestApp
//
//  Created by Клим on 28.10.2021.
//

import Foundation

protocol FilterTypeModelProtocol {
    var contacts: [Item] { get set }
    
    init(contacts: [Item])
}

class FilterTypeModel: FilterTypeModelProtocol {
    var contacts: [Item] = []
    
    required init(contacts: [Item]) {
        self.contacts = contacts
    }
    

}
