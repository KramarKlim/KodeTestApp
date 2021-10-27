//
//  ContactModel.swift
//  KodeTestApp
//
//  Created by Клим on 27.10.2021.
//

import Foundation

protocol ContactModelProtocol {
    var contact: Item { get }
    
    init(contact: Item)
    
    func getImage() -> String
    func getName() -> String
    func getPosition() -> String
    func getTag() -> String
}

class ContactModel: ContactModelProtocol {
    var contact: Item
    
    required init(contact: Item) {
        self.contact = contact
    }
    
    func getImage() -> String {
        contact.avatarUrl ?? DataManager.shared.imageError
    }
    
    func getName() -> String {
        (contact.firstName ?? "Неизвестно") + (contact.lastName ?? "Неизвестно")
    }
    
    func getPosition() -> String {
        contact.position ?? "Неизвестно"
    }
    
    func getTag() -> String {
        contact.userTag ?? "Неизвестно"
    }
    
    
}
