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
    var isError: Bool { get set }
    var twentyOne: [Item] { get set }
    var twentyTwo: [Item] { get set }
    var filteredSecond: [Item] { get set }
    var isFiltered: Bool { get set }
    
    func numberOfCells() -> Int
    func bugs(text: String) -> Bool
    func didChanged(text: String)
    func sortedList(indexPath: IndexPath) -> SortedListModelProtocol?
    func fetchRequest(completion: @escaping () -> Void)
    func getNumberOfRows(section: Int) -> Int
    func contactModel(indexPath: IndexPath) -> ContactModelProtocol?
    func profileModel(indexPath: IndexPath) -> ProfileModelProtocol?
    func sortContact()
    func sortByProf(indexPath: IndexPath)
    func numberOfSections() -> Int
    func getCurrentTime(format: String) -> String
    func heightForHeaderInSection(section: Int) -> CGFloat
}

class ContactListModel: ContactListModelProtocol {
    
    var isFiltered: Bool = false
    
    var isError: Bool = true
    
    var department: [Item] = []
    
    var sortType: SortType = .nothing
    
    var filtered: [Item] = []
    
    var filteredSecond: [Item] = []
    
    var isSearching: Bool = false
    
    var contacts: [Item] = []
    
    var lastActiveIndex: IndexPath = [0,0]
    
    var twentyOne: [Item] = []
    
    var twentyTwo: [Item] = []
    
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
                if self.isFiltered == false {
                    self.department = self.contacts
                    self.isFiltered = true
                }
                self.isError = true
            }
            completion()
        }
    }
    
    func getNumberOfRows(section: Int) -> Int {
        if isSearching && sortType != .date {
            return filtered.count
        } else if isSearching {
            switch section {
            case 0: return filtered.count
            case 1: return filteredSecond.count
            default: return 0
            }
        } else if sortType == .date {
            switch section {
            case 0: return twentyOne.count
            case 1: return twentyTwo.count
            default: return 0
            }
        } else {
            return department.count
        }
    }
    
    func contactModel(indexPath: IndexPath) -> ContactModelProtocol? {
        if isSearching && sortType != .date {
            return ContactModel(contact: filtered[indexPath.row], type: sortType)
        } else if isSearching {
            switch indexPath.section {
            case 0: return ContactModel(contact: filtered[indexPath.row], type: sortType)
            case 1: return ContactModel(contact: filteredSecond[indexPath.row], type: sortType)
            default: return nil
            }
        } else if sortType == .date {
            switch indexPath.section {
            case 0: return ContactModel(contact: twentyOne[indexPath.row], type: sortType)
            case 1: return ContactModel(contact: twentyTwo[indexPath.row], type: sortType)
            default: return nil
            }
        } else {
            return ContactModel(contact: department[indexPath.row], type: sortType)
        }
    }
    
    func bugs(text: String) -> Bool {
        text != " "
    }
    
    func didChanged(text: String) {
        if sortType == .date {
            filtered = twentyOne.filter { item in
                (item.firstName ?? "").prefix(text.count) == text ||
                (item.lastName ?? "").prefix(text.count) == text ||
                (item.userTag?.lowercased() ?? "").prefix(text.count) == text
            }
            filteredSecond = twentyTwo.filter { item in
                (item.firstName ?? "").prefix(text.count) == text ||
                (item.lastName ?? "").prefix(text.count) == text ||
                (item.userTag?.lowercased() ?? "").prefix(text.count) == text
            }
        } else {
            filtered = department.filter { item in
                (item.firstName ?? "").prefix(text.count) == text ||
                (item.lastName ?? "").prefix(text.count) == text ||
                (item.userTag?.lowercased() ?? "").prefix(text.count) == text
            }
        }
        if text == "" {
            isSearching = false
        } else {
            isSearching = true
        }
    }
    
    func profileModel(indexPath: IndexPath) -> ProfileModelProtocol? {
        if isSearching && sortType != .date {
            return ProfileModel(profile: filtered[indexPath.row])
        } else if isSearching {
            switch indexPath.section {
            case 0: return ProfileModel(profile: filtered[indexPath.row])
            case 1: return ProfileModel(profile: filteredSecond[indexPath.row])
            default: return nil
            }
        } else if sortType == .date {
            switch indexPath.section {
            case 0: return ProfileModel(profile: twentyOne[indexPath.row])
            case 1: return ProfileModel(profile: twentyTwo[indexPath.row])
            default: return nil
            }
        } else {
            return ProfileModel(profile: department[indexPath.row])
        }
    }
    
    func sortContact() {
        switch sortType {
        case .date:
            twentyOne = department.filter{($0.birthday?.convertDateFormater(currentFormat: "yyyy-MM-dd", needFromat: "MM dd"))! >= getCurrentTime(format: "MM dd")}
            twentyOne = twentyOne.sorted{($0.birthday?.convertDateFormater(currentFormat: "yyyy-MM-dd", needFromat: "MM dd") ?? "Неизвестно") < ($1.birthday?.convertDateFormater(currentFormat: "yyyy-MM-dd", needFromat: "MM dd") ?? "Неизвестно")}
            twentyTwo =  department.filter{($0.birthday?.convertDateFormater(currentFormat: "yyyy-MM-dd", needFromat: "MM dd"))! < getCurrentTime(format: "MM dd")}
            twentyTwo = twentyTwo.sorted{($0.birthday?.convertDateFormater(currentFormat: "yyyy-MM-dd", needFromat: "MM dd") ?? "Неизвестно") < ($1.birthday?.convertDateFormater(currentFormat: "yyyy-MM-dd", needFromat: "MM dd") ?? "Неизвестно")}
        case .word:
            contacts = contacts.sorted{($0.firstName ?? "Неизвестно") < ($1.firstName ?? "Неизвестно")}
            department = department.sorted{($0.firstName ?? "Неизвестно") < ($1.firstName ?? "Неизвестно")}
        case .nothing: break
        }
    }
    
    func sortByProf(indexPath: IndexPath) {
        guard let contact = Professions.init(rawValue: DataManager.shared.sortingType[indexPath.row]) else { return department = contacts}
        department = contacts.filter{$0.department == contact.description}
    }
    
    func getCurrentTime(format: String) -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return  formatter.string(from: date)
    }
    
    func numberOfSections() -> Int {
        if sortType == .date {
            return 2
        }
        return 1
    }
    
    func heightForHeaderInSection(section: Int) -> CGFloat {
        if section == 1 && sortType == .date {
            return 50
        } else {
            return 0
        }
    }
}
