//
//  ProfileModel.swift
//  KodeTestApp
//
//  Created by Клим on 28.10.2021.
//

import Foundation

protocol ProfileModelProtocol {
    var profile: Item { get }
    
    init(profile: Item)
    
    func getImage() -> String?
    func getName() -> String
    func getTag() -> String
    func getProf() -> String
    func getYears() -> String
    func getNumber() -> String
    func getDate() -> String
    func numberToCall() -> String
}

class ProfileModel: ProfileModelProtocol {
    var profile: Item
    
    required init(profile: Item) {
        self.profile = profile
    }
    
    func getImage() -> String? {
        profile.avatarUrl
    }
    
    func getName() -> String {
        (profile.firstName ?? "Неизвестно") + " " + (profile.lastName ?? "Неизвестно")
    }
    
    func getTag() -> String {
        profile.userTag?.lowercased() ?? "Неизвестно"
    }
    
    func getProf() -> String {
        profile.position ?? "Неизвестно"
    }
    
    func getYears() -> String {
        (profile.birthday?.calcAge(dateFormatter: "yyyy-MM-dd") ?? "Неизвестно") + " " + (profile.birthday?.calcAge(dateFormatter: "yyyy-MM-dd").rightYear() ?? "Неизвестно")
    }
    
    func getNumber() -> String {
        profile.phone?.format(with: "  +X (XXX) XXX XX XX") ?? "Неизвестно"
    }
    
    func getDate() -> String {
        let day = profile.birthday?.convertDateFormater(currentFormat: "yyyy-MM-dd", needFromat: "dd") ?? "Неизвестно"
        let monthEng = profile.birthday?.convertDateFormater(currentFormat: "yyyy-MM-dd", needFromat: "MMMM") ?? "Неизвестно"
        let year = profile.birthday?.convertDateFormater(currentFormat: "yyyy-MM-dd", needFromat: "yyyy") ?? "Неизвестно"
        guard let month = MonthRussian.init(rawValue: monthEng) else { return "Неизвестно"}
        return day + " " + "\(month.russianTranslate)" + " " + year
    }
    
    func numberToCall() -> String {
        profile.phone?.format(with: "+XXXXXXXXXXX") ?? "Неизвестно"
    }
}
