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
        var index = numbers.startIndex // numbers iterator

        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
}
