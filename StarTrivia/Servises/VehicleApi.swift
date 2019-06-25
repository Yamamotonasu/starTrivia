//
//  VehicleApi.swift
//  StarTrivia
//
//  Created by 山本裕太 on 2019/06/25.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import Foundation
import Alamofire

class VehicleApi {
    func getVehicle(url: String, completion: @escaping VehicleResponseCompletion) {
        guard let url = URL(string: url) else { return }
        Alamofire.request(url).responseJSON { (response) in
            if let error = response.result.error {
                debugPrint(error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = response.data else { return completion(nil) }
            let jsonDecoder = JSONDecoder()
            do {
                let vehicle = try jsonDecoder.decode(Vehicles.self, from: data)
                completion(vehicle)
            } catch {
                debugPrint(error.localizedDescription)
                completion(nil)
            }
        }
    }
}
