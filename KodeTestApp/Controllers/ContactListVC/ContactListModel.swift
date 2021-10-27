//
//  ContactListModel.swift
//  KodeTestApp
//
//  Created by Клим on 27.10.2021.
//

import Foundation

protocol ContactListModelProtocol {
    var lastActiveIndex: IndexPath { get set }
    var contacts: [Item] { get }
    
    func numberOfCells() -> Int
    func sortedList(indexPath: IndexPath) -> SortedListModelProtocol?
    func fetchRequest(completion: @escaping () -> Void)
    func getNumberOfRows() -> Int
    func contactModel(indexPath: IndexPath) -> ContactModelProtocol?
}

class ContactListModel: ContactListModelProtocol {
    
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
        contacts.count
    }
    
    func contactModel(indexPath: IndexPath) -> ContactModelProtocol? {
        return ContactModel(contact: contacts[indexPath.row])
    }
    
}
