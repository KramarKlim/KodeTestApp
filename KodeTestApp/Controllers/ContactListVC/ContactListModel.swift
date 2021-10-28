//
//  ContactListModel.swift
//  KodeTestApp
//
//  Created by Клим on 27.10.2021.
//

import Foundation
import UIKit

protocol ContactListModelProtocol {
    var lastActiveIndex: IndexPath { get set }
    var contacts: [Item] { get set }
    var filtered: [Item] { get set }
    var isSearching: Bool { get set }
    
    func numberOfCells() -> Int
    func bugs(text: String) -> Bool
    func didChanged(text: String)
    func sortedList(indexPath: IndexPath) -> SortedListModelProtocol?
    func fetchRequest(completion: @escaping () -> Void)
    func getNumberOfRows() -> Int
    func contactModel(indexPath: IndexPath) -> ContactModelProtocol?
}

class ContactListModel: ContactListModelProtocol {
    
    var filtered: [Item] = []
    
    var isSearching: Bool = false
    
    var contacts: [Item] = []
    
    var lastActiveIndex: IndexPath = [0,0]
    
    func numberOfCells() -> Int {
        DataManager.shared.sortingType.count
    }
    
    func sortedList(indexPath: IndexPath) -> SortedListModelProtocol? {
        return SortedListModel(name: DataManager.shared.sortingType[indexPath.row])
    }
    
    func fetchRequest(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchNetwork(headers: DataManager.shared.headers, request: DataManager.shared.request, expecting: User.self) { [self] user in
            self.contacts = user.items ?? []
            completion()
        }
    }
    
    func getNumberOfRows() -> Int {
        if isSearching {
            return filtered.count
        } else {
            return contacts.count
        }
    }
    
    func contactModel(indexPath: IndexPath) -> ContactModelProtocol? {
        if isSearching {
            return ContactModel(contact: filtered[indexPath.row])
        } else {
            return ContactModel(contact: contacts[indexPath.row])
        }
    }
    
    func bugs(text: String) -> Bool {
        text != " "
    }
    
    func didChanged(text: String) {
        filtered = contacts.filter({($0.firstName ?? "Неизвестно").prefix(text.count) == text })
        isSearching = true
    }
}
