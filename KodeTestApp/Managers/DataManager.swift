//
//  DataManager.swift
//  KodeTestApp
//
//  Created by Клим on 27.10.2021.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    let sortingType = ["Все", "Designers", "Analysts", "Managers", "iOS", "Android", "QA", "Back-Officers", "Frotends", "HR", "Supports", "PR"]
    
    let request = NSMutableURLRequest(url: NSURL(string: "https://stoplight.io/mocks/kode-education/trainee-test/25143926/users")! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    let imageError = "https://thumbs.dreamstime.com/b/вектор-значка-профиля-аватары-по-умолчанию-неизвестное-социальное-184816085.jpg"
    
    func errorType(type: CriticalError) -> [String: String]{
        switch type {
        case .success: return ["Content-Type": "application/json","Prefer": "code=200, example=success"]
        case .random: return ["Content-Type": "application/json","Prefer": "code=200, dynamic=true"]
        case .error: return ["Content-Type": "application/json","Prefer": "code=500, example=error-500"]
        }
    }
}
