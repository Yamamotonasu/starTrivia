//
//  Vehicle.swift
//  StarTrivia
//
//  Created by 山本裕太 on 2019/06/25.
//  Copyright © 2019 山本裕太. All rights reserved.
//
/// must write business logic and struct(immutable)

import Foundation

struct Vehicles : Codable {
    
    let name: String
    let model: String
    let manufacturer: String
    let cost: String
    let length: String
    let speed: String
    let crew: String
    let passengers: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case model
        case manufacturer
        case cost = "cost_in_credits"
        case length
        case speed = "max_atmosphering_speed"
        case crew
        case passengers
    }
}
