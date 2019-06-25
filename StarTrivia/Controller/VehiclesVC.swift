//
//  VehiclesVC.swift
//  StarTrivia
//
//  Created by 山本裕太 on 2019/06/24.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit

class VehiclesVC: UIViewController, PersonProtocol {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var modelLbl: UILabel!
    @IBOutlet weak var manufactureLbl: UILabel!
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var lengthLbl: UILabel!
    @IBOutlet weak var speedLbl: UILabel!
    @IBOutlet weak var crewLbl: UILabel!
    @IBOutlet weak var passengerLbl: UILabel!
    @IBOutlet weak var previousLbl: UIButton!
    @IBOutlet weak var nextLbl: UIButton!
    
    var person: Person!
    let api = VehicleApi()
    var vehicles = [String]()
    var currentVehicle = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        /// 乗り物の配列(API)を取得する
        vehicles = person.vehicleUrls
        /// 1以上ならtrueになる 逆に1以下なら押せない
        nextLbl.isEnabled = vehicles.count > 1
        /// 最初は必ずpreviousButtonを無効にして始める必要がある
        previousLbl.isEnabled = false
        guard let firstVehicle = vehicles.first else { return }
        getVehicle(url: firstVehicle)
    }
    
    func getVehicle(url: String) {
        /// 第二引数はvehicleだがクロージャを定義して代入する
        api.getVehicle(url: url) { (vehicle) in
            if let vehicle = vehicle {
                self.setupView(vehicle: vehicle)
            }
        }
    }
    
    /// 返り値はVehiclesの構造体の中身に従う事
    func setupView(vehicle: Vehicles) {
        nameLbl.text = vehicle.name
        modelLbl.text = vehicle.model
        manufactureLbl.text = vehicle.manufacturer
        costLbl.text = vehicle.cost
        lengthLbl.text = vehicle.length
        speedLbl.text = vehicle.speed
        crewLbl.text = vehicle.crew
        passengerLbl.text = vehicle.passengers
    }
    
    @IBAction func previousClicked(_ sender: Any) {
        currentVehicle -= 1
        setButtonState()
    }
    @IBAction func nextClicked(_ sender: Any) {
        currentVehicle += 1
        setButtonState()
    }
    
    func setButtonState() {
        nextLbl.isEnabled = currentVehicle == vehicles.count - 1 ? false : true
        previousLbl.isEnabled = currentVehicle == 0 ? false : true
//        if currentVehicle == 0 {
//            previousLbl.isEnabled = false
//        } else {
//            previousLbl.isEnabled = true
//        }
//
//        if currentVehicle == vehicles.count - 1 {
//            nextLbl.isEnabled = false
//        } else {
//            nextLbl.isEnabled = true
//        }
        
        getVehicle(url: vehicles[currentVehicle])
    }
}
