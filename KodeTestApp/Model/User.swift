//
//  User.swift
//  KodeTestApp
//
//  Created by Клим on 27.10.2021.
//

import Foundation

struct User: Codable {
    let items: [Item]?
}

struct Item: Codable {
    let id: String?
    let avatarUrl: String?
    let firstName: String?
    let lastName: String?
    let userTag: String?
    let department: String?
    let position: String?
    let birthday: String?
}
