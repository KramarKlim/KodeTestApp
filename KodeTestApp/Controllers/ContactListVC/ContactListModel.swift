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
    var department: [Item] { get set}
    var isSorted: Bool { get set }
    var isError: Bool { get set }
    
    func numberOfCells() -> Int
    func bugs(text: String) -> Bool
    func didChanged(text: String)
    func sortedList(indexPath: IndexPath) -> SortedListModelProtocol?
    func fetchRequest(completion: @escaping () -> Void)
    func getNumberOfRows() -> Int
    func contactModel(indexPath: IndexPath) -> ContactModelProtocol?
    func profileModel(indexPath: IndexPath) -> ProfileModelProtocol?
    func sortContact()
    func sortByProf(indexPath: IndexPath)
}

class ContactListModel: ContactListModelProtocol {
    
    var isError: Bool = true
    
    var isSorted: Bool = false
    
    var department: [Item] = []
    
    var sortType: SortType = .nothing
    
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
        NetworkDataFetcher.shared.getData(headers: DataManager.shared.errorType(type: .success), request: DataManager.shared.request, decodeType: User.self) { result in
            self.isError = true
            if result?.items == nil {
                self.isError = false
            } else {
                self.contacts = result?.items ?? []
                self.isError = true
            }
            completion()
        }
    }
    
    func getNumberOfRows() -> Int {
        if isSearching {
            return filtered.count
        } else if isSorted == false{
            return contacts.count
        } else {
            return department.count
        }
    }
    
    func contactModel(indexPath: IndexPath) -> ContactModelProtocol? {
        if isSearching {
            return ContactModel(contact: filtered[indexPath.row], type: sortType)
        } else if isSorted == false {
            return ContactModel(contact: contacts[indexPath.row], type: sortType)
        } else {
            return ContactModel(contact: department[indexPath.row], type: sortType)
        }
    }
    
    func bugs(text: String) -> Bool {
        text != " "
    }
    
    func didChanged(text: String) {
        if isSorted == false {
            filtered = contacts.filter({($0.firstName ?? "Неизвестно").prefix(text.count) == text })
        } else {
            filtered = department.filter({($0.firstName ?? "Неизвестно").prefix(text.count) == text })
        }
        isSearching = true
    }
    
    func profileModel(indexPath: IndexPath) -> ProfileModelProtocol? {
        if isSearching {
            return ProfileModel(profile: filtered[indexPath.row])
        } else if isSorted == false {
            return ProfileModel(profile: contacts[indexPath.row])
        } else {
            return ProfileModel(profile: department[indexPath.row])
        }
    }
    
    func sortContact() {
        if isSorted == false {
            switch sortType {
            case .date: contacts = contacts.sorted{($0.birthday?.convertDateFormater(currentFormat: "yyyy-MM-dd", needFromat: "MMMM dd") ?? "Неизвестно") < ($1.birthday?.convertDateFormater(currentFormat: "yyyy-MM-dd", needFromat: "MMMM dd") ?? "Неизвестно")}
            case .word: contacts = contacts.sorted{($0.firstName ?? "Неизвестно") < ($1.firstName ?? "Неизвестно")}
            case .nothing: break
            }
        } else {
            switch sortType {
            case .date: department = department.sorted{($0.birthday?.convertDateFormater(currentFormat: "yyyy-MM-dd", needFromat: "MMMM dd") ?? "Неизвестно") < ($1.birthday?.convertDateFormater(currentFormat: "yyyy-MM-dd", needFromat: "MMMM dd") ?? "Неизвестно")}
            case .word: department = department.sorted{($0.firstName ?? "Неизвестно") < ($1.firstName ?? "Неизвестно")}
            case .nothing: break
            }
        }
    }
    
    func sortByProf(indexPath: IndexPath) {
        guard let contact = Professions.init(rawValue: DataManager.shared.sortingType[indexPath.row]) else { return department = contacts}
        department = contacts.filter{$0.department == contact.description}
    }
}
