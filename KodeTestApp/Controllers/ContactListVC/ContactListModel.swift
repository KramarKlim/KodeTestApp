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
    var sortType: SortType { get set }
    var prof: [Item] { get set}
    var sorted: Bool { get set }
    
    func numberOfCells() -> Int
    func bugs(text: String) -> Bool
    func didChanged(text: String)
    func sortedList(indexPath: IndexPath) -> SortedListModelProtocol?
    func fetchRequest(completion: @escaping () -> Void)
    func getNumberOfRows() -> Int
    func contactModel(indexPath: IndexPath) -> ContactModelProtocol?
    func profileModel(inedxPath: IndexPath) -> ProfileModelProtocol?
    func sortContact()
    func sortByProf(indexPath: IndexPath)
}

class ContactListModel: ContactListModelProtocol {
    
    var sorted: Bool = false
    
    var prof: [Item] = []
    
    var sortType: SortType = .word
    
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
            self.contacts = user.items?.sorted{($0.firstName ?? "Неизвестно") < ($1.firstName ?? "Неизвестно")} ?? []
            completion()
        }
    }
    
    func getNumberOfRows() -> Int {
        if isSearching {
            return filtered.count
        } else if sorted == false{
            return contacts.count
        } else {
            return prof.count
        }
    }
    
    func contactModel(indexPath: IndexPath) -> ContactModelProtocol? {
        if isSearching {
            return ContactModel(contact: filtered[indexPath.row], type: sortType)
        } else if sorted == false {
            return ContactModel(contact: contacts[indexPath.row], type: sortType)
        } else {
            return ContactModel(contact: prof[indexPath.row], type: sortType)
        }
    }
    
    func bugs(text: String) -> Bool {
        text != " "
    }
    
    func didChanged(text: String) {
        if sorted == false {
        filtered = contacts.filter({($0.firstName ?? "Неизвестно").prefix(text.count) == text })
        } else {
            filtered = prof.filter({($0.firstName ?? "Неизвестно").prefix(text.count) == text })
        }
        isSearching = true
    }
    
    func profileModel(inedxPath: IndexPath) -> ProfileModelProtocol? {
        if isSearching {
            return ProfileModel(profile: filtered[inedxPath.row])
        } else if sorted == false {
            return ProfileModel(profile: contacts[inedxPath.row])
        } else {
            return ProfileModel(profile: prof[inedxPath.row])
        }
    }
    
    func sortContact() {
        if sorted == false {
        switch sortType {
        case .date: contacts = contacts.sorted{($0.birthday ?? "Неизвестно") < ($1.birthday ?? "Неизвестно")}
        case .word: contacts = contacts.sorted{($0.firstName ?? "Неизвестно") < ($1.firstName ?? "Неизвестно")}
        }
        } else {
            switch sortType {
            case .date: prof = prof.sorted{($0.birthday ?? "Неизвестно") < ($1.birthday ?? "Неизвестно")}
            case .word: prof = prof.sorted{($0.firstName ?? "Неизвестно") < ($1.firstName ?? "Неизвестно")}
            }
        }
    }
    
    func sortByProf(indexPath: IndexPath) {
        switch indexPath.row {
        case 0: prof = contacts
        case 1: prof = contacts.filter{$0.department == "design"}
        case 2: prof = contacts.filter{$0.department == "analytics"}
        case 3: prof = contacts.filter{$0.department == "management"}
        case 4: prof = contacts.filter{$0.department == "ios"}
        case 5: prof = contacts.filter{$0.department == "android"}
        case 6: prof = contacts.filter{$0.department == "qa"}
        case 7: prof = contacts.filter{$0.department == "back_office"}
        case 8: prof = contacts.filter{$0.department == "frontend"}
        case 9: prof = contacts.filter{$0.department == "hr"}
        case 10: prof = contacts.filter{$0.department == "support"}
        case 11: prof = contacts.filter{$0.department == "pr"}
        default: break
        }
    }
}
