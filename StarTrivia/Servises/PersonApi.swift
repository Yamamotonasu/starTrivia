//
//  PersonApi.swift
//  StarTrivia
//
//  Created by 山本裕太 on 2019/06/23.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PersonApi {
    // Web request with Alamofire and Codable
    func getRandomPersonUrlSessionAlamo(id: Int, completion: @escaping PersonResponseCompletion) {
        
        /// urlが存在しなければ何もしない(error handling)
        /// guard文だと以降でも変数を使用する事ができる
        guard let url = URL(string: "\(PERSON_URL)\(id)") else { return }
        
        Alamofire.request(url).responseJSON { (response) in
            
            /// エラー時の処理
            if let error = response.result.error {
                debugPrint(error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = response.data else {
                return completion(nil)
            }
            let jsonDecoder = JSONDecoder()
            do {
                let person = try jsonDecoder.decode(Person.self, from: data)
                completion(person)
            } catch {
                debugPrint(error.localizedDescription)
                completion(nil)
            }
        }
        
    }
    
//    ///web request with Alamofire and SwiftyJSON
//    func getRandomPersonUrlSessionAlamo(id: Int, completion: @escaping PersonResponseCompletion) {
//
//        /// urlが存在しなければ何もしない(error handling)
//        /// guard文だと以降でも変数を使用する事ができる
//        guard let url = URL(string: "\(PERSON_URL)\(id)") else { return }
//
//        Alamofire.request(url).responseJSON { (response) in
//
//            /// エラー時の処理
//            if let error = response.result.error {
//                debugPrint(error.localizedDescription)
//                completion(nil)
//                return
//            }
//
//            guard let data = response.data else {
//                return completion(nil)
//            }
//            do {
//                let json = try JSON(data: data)
//                let person = self.parsePersonSwifty(json: json)
//                completion(person)
//            } catch {
//                debugPrint(error.localizedDescription)
//                completion(nil)
//            }
//        }
//
//    }
    
    // web request with Alamofire
//    func getRandomPersonUrlSessionAlamo(id: Int, completion: @escaping PersonResponseCompletion) {
//
//        /// urlが存在しなければ何もしない(error handling)
//        /// guard文だと以降でも変数を使用する事ができる
//        guard let url = URL(string: "\(PERSON_URL)\(id)") else { return }
//
//        Alamofire.request(url).responseJSON { (response) in
//
//            /// エラー時の処理
//            if let error = response.result.error {
//                debugPrint(error.localizedDescription)
//                completion(nil)
//                return
//            }
//
//            guard let json = response.result.value as? [String: Any] else {
//                return completion(nil)
//            }
//            let person = self.parsePersonManual(json: json)
//            completion(person)
//        }
//
//    }
    
    
    
    // web request with URL session
    func getRandomPersonUrlSession(id: Int, completion: @escaping PersonResponseCompletion) {
        
        /// urlが存在しなければ何もしない(error handling)
        /// guard文だと以降でも変数を使用する事ができる
        guard let url = URL(string: "\(PERSON_URL)\(id)") else { return }
        
        
        /// urlを渡して解析したデータを戻り値として返すように要求する(task)
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                debugPrint(error.debugDescription)
                completion(nil)
                return
            }
            
            /// dataが存在しなければ何もしない
            guard let data = data else { return }
            
            do {
                let jsonAny = try JSONSerialization.jsonObject(with: data, options: [])
                guard let json = jsonAny as? [String: Any] else { return }
                let person = self.parsePersonManual(json: json)
                ///バックスレッドで実行する。実行が終了したら、メインスレッドに戻る
                DispatchQueue.main.async {
                    /// 処理が完了したらpersonを返却
                    completion(person)
                }
            } catch {
                debugPrint(error.localizedDescription)
                return
            }
            
//            print("Data = \(data)")
//            print("Response = \(response)")
        }
        task.resume()
    }
    
    /// parsing with SwiftyJSON
    private func parsePersonSwifty(json: JSON) -> Person{
        
        /// String型にキャストする、失敗したら空文字を挿入する
        let name = json["name"].stringValue
        let height = json["height"].stringValue
        let mass = json["mass"].stringValue
        let hair = json["hair_color"].stringValue
        let birthYear = json["birth_year"].stringValue
        let gender = json["gender"].stringValue
        let homeworldUrl = json["homeworld"].stringValue
        // 各
        let filmUrls = json["films"].arrayValue.map({ $0.stringValue })
        let vehicleUrls = json["vehicles"].arrayValue.map({ $0.stringValue })
        let starshipUrls = json["starships"].arrayValue.map({ $0.stringValue })
        
        return Person(name: name, height: height, mass: mass, hair: hair, birthYear: birthYear, gender:gender, homeworldUrl: homeworldUrl, filmUrls: filmUrls, vehicleUrls: vehicleUrls, starshipUrls: starshipUrls)
    }
    
    
    /// Persing function using manual methods
    /// 構造体からインスタンスを作成する。jsonのフォーマットを返す関数
    private func parsePersonManual(json: [String: Any]) -> Person{
        
        /// String型にキャストする、失敗したら空文字を挿入する
        let name = json["name"] as? String ?? ""
        let height = json["height"] as? String ?? ""
        let mass = json["mass"] as? String ?? ""
        let hair = json["hair_color"] as? String ?? ""
        let birthYear = json["birth_year"] as? String ?? ""
        let gender = json["gender"] as? String ?? ""
        let homeworldUrl = json["homeworld"] as? String ?? ""
        let filmUrls = json["films"] as? [String] ?? [String]()
        let vehicleUrls = json["vehicles"] as? [String] ?? [String]()
        let starshipUrls = json["starships"] as? [String] ?? [String]()
        
        return Person(name: name, height: height, mass: mass, hair: hair, birthYear: birthYear, gender:gender, homeworldUrl: homeworldUrl, filmUrls: filmUrls, vehicleUrls: vehicleUrls, starshipUrls: starshipUrls)
    }
}
