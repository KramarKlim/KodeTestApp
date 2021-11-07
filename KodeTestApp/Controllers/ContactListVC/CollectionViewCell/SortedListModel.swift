//
//  SortedListModel.swift
//  KodeTestApp
//
//  Created by Клим on 27.10.2021.
//

import Foundation

protocol SortedListModelProtocol {
    var name: String { get }
    
    init(name: String)
}

class SortedListModel: SortedListModelProtocol {
    var name: String
    
    required init(name: String) {
        self.name = name
    }
    
    
}
