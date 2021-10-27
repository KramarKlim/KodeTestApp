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
    
    let sortingType = ["Все", "Designers", "Analysts", "Managers", "IOS", "Android", "QA", "Back_office", "Frotend", "HR", "Supports"]
    
    
    let headers = [
        "Content-Type": "application/json",
        "Prefer": "code=200, example=success"
    ]
    
    let request = NSMutableURLRequest(url: NSURL(string: "https://stoplight.io/mocks/kode-education/trainee-test/25143926/users")! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    let imageError = "https://thumbs.dreamstime.com/b/вектор-значка-профиля-аватары-по-умолчанию-неизвестное-социальное-184816085.jpg"
}
