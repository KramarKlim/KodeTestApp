//
//  String.swift
//  KodeTestApp
//
//  Created by Клим on 28.10.2021.
//

import Foundation

extension String {
    func convertDateFormater(currentFormat: String, needFromat: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currentFormat
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = needFromat
        return  dateFormatter.string(from: date!)
    }
    
    func calcAge(dateFormatter: String) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = dateFormatter
        let birthdayDate = dateFormater.date(from: self)
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
        let age = calcAge.year
        return String(age!)
    }
    
    func format(with mask: String) -> String {
        let numbers = "7\(self)".replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
                
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func rightYear() -> String {
        guard self != "11" else { return "лет"}
        guard self != "12" else { return "лет"}
        guard self != "13" else { return "лет"}
        guard self != "14" else { return "лет"}
        
        guard let number = Int(self) else { return "Неизвестно" }
        switch number % 10 {
        case 0: return "лет"
        case 5...9: return "лет"
        case 2...4: return "года"
        case 1: return "год"
        default: break
        }
        return "Неизвестно"
    }
}
