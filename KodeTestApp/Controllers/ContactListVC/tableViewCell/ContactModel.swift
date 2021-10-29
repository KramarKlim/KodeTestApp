//
//  ContactModel.swift
//  KodeTestApp
//
//  Created by Клим on 27.10.2021.
//

import Foundation

protocol ContactModelProtocol {
    var contact: Item { get }
    var type: SortType { get }
    
    init(contact: Item, type: SortType)
    
    func getImage() -> String
    func getName() -> String
    func getPosition() -> String
    func getTag() -> String
    func getDay() -> String?
}

class ContactModel: ContactModelProtocol {
    var contact: Item
    
    var type: SortType
    
    required init(contact: Item, type: SortType) {
        self.contact = contact
        self.type = type
    }
    
    func getImage() -> String {
        contact.avatarUrl ?? DataManager.shared.imageError
    }
    
    func getName() -> String {
        (contact.firstName ?? "Неизвестно") + " " + (contact.lastName ?? "Неизвестно")
    }
    
    func getPosition() -> String {
        contact.position ?? "Неизвестно"
    }
    
    func getTag() -> String {
        contact.userTag ?? "Неизвестно"
    }
    
    func getDay() -> String? {
        if type == .word {
          return nil
        } else {
            return contact.birthday?.convertDateFormater(currentFormat: "yyyy-MM-dd", needFromat: "dd MMM" ) ?? "Неизвестно"
        }
    }
}
