//
//  Constants.swift
//  StarTrivia
//
//  Created by 山本裕太 on 2019/06/22.
//  Copyright © 2019 山本裕太. All rights reserved.
//

/// 定数を定義する
import UIKit

let BLACK_BG = UIColor.black.withAlphaComponent(0.6).cgColor

let URL_BASE = "http://swapi.co/api/"
let PERSON_URL = URL_BASE + "people/"


/// Person structureを使い、何も返さないtypealias
typealias PersonResponseCompletion = (Person?) -> Void

typealias HomeworldResponseCompletion = (Homeworld?) -> Void

/// Vehiclesに準拠していて、戻り値がなし
typealias VehicleResponseCompletion = (Vehicles?) -> Void

/// responseにnilが帰ってくる可能性があるので構造体に?を付ける
typealias StarshipResponseCompletion = (Starship?) -> Void

typealias FilmResponseCompletion = (Film?) -> Void
