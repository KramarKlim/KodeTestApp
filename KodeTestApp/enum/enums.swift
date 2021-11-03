//
//  enum.swift
//  KodeTestApp
//
//  Created by Клим on 29.10.2021.
//

import Foundation

enum SortType {
    case date, word, nothing
}

enum MonthRussian: String {
    case january = "January"
    case february = "February"
    case march = "March"
    case april = "April"
    case may = "May"
    case june = "June"
    case july = "July"
    case august = "August"
    case september = "September"
    case october = "October"
    case november = "November"
    case december = "December"
    
    var russianTranslate: String {
        switch self {
        case .january: return "января"
        case .february: return "февраля"
        case .march: return "марта"
        case .april: return "апреля"
        case .may: return "мая"
        case .june: return "июня"
        case .july: return "июля"
        case .august: return "августа"
        case .september: return "сентября"
        case .october: return "октября"
        case .november: return "ноября"
        case .december: return "декабря"
        }
    }
}

enum CriticalError {
    case success, random, error
}

enum Professions: String {
    case android = "Android"
    case design = "Designers"
    case analytics = "Analysts"
    case management = "Managers"
    case ios = "iOS"
    case qa = "QA"
    case back_office = "Back-Officers"
    case frontend = "Frotends"
    case hr = "HR"
    case support = "Supports"
    case pr = "PR"
    
    var description: String {
        switch self {
        case .android: return "android"
        case .design: return "design"
        case .analytics: return "analytics"
        case .management: return "management"
        case .ios: return "ios"
        case .qa: return "qa"
        case .back_office: return "back_office"
        case .frontend: return "frontend"
        case .hr: return "hr"
        case .support: return "support"
        case .pr: return "pr"
        }
    }
}
