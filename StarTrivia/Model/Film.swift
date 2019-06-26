//
//  Film.swift
//  StarTrivia
//
//  Created by 山本裕太 on 2019/06/27.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import Foundation

struct Film: Codable {
    let title: String
    let episode: Int
    let crawl: String
    let director: String
    let producer: String
    let releaseData: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case episode = "episode_id"
        case director
        case crawl = "opening_crawl"
        case producer
        case releaseData
    }
}
