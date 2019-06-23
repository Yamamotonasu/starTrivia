//
//  Person.swift
//  StarTrivia
//
//  Created by 山本裕太 on 2019/06/23.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import Foundation

struct Person: Codable {
    let name: String
    let height: String
    let mass: String
    let hair: String
    let birthYear: String
    let gender: String
    let homeworldUrl: String
    let filmUrls: [String]
    let vehicleUrls: [String]
    let starshipUrls: [String]
    
    
    /// パラメータとjsonのkeyが一致しない場合enumで定義する必要がある。
    enum CodingKeys: String, CodingKey {
        case name
        case height
        case mass
        case hair = "hair_color"
        case birthYear = "birth_year"
        case gender
        case homeworldUrl = "homeworld"
        case filmUrls = "films"
        case vehicleUrls = "vehicles"
        case starshipUrls = "starships"
    }
}
