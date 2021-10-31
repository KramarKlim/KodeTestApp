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
