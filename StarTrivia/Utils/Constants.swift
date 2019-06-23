//
//  Constants.swift
//  StarTrivia
//
//  Created by 山本裕太 on 2019/06/22.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit

let BLACK_BG = UIColor.black.withAlphaComponent(0.6).cgColor

let URL_BASE = "http://swapi.co/api/"
let PERSON_URL = URL_BASE + "people/"


/// Person structureを使い、何も返さないtypealias
typealias PersonResponseCompletion = (Person?) -> Void