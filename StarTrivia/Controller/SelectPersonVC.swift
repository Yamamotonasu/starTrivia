//
//  ViewController.swift
//  StarTrivia
//
//  Created by 山本裕太 on 2019/06/22.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit

class SelectPersonVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var massLbl: UILabel!
    @IBOutlet weak var hairLbl: UILabel!
    @IBOutlet weak var birthYearLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    
    @IBOutlet weak var homeworldBtn: UIButton!
    @IBOutlet weak var vehiclesBtn: UIButton!
    @IBOutlet weak var starshipsBtn: UIButton!
    @IBOutlet weak var filmsBtn: UIButton!
    
    var personApi = PersonApi()
    var person: Person!
    override func viewDidLoad() {
        super.viewDidLoad()
        // step1: makenetworking request
    }

    @IBAction func randomClicked(_ sender: Any) {
        let random = Int.random(in: 1...87)
        personApi.getRandomPersonUrlSessionAlamo(id: random) { (person) in
            if let person = person {
                self.setupView(person: person)
                self.person = person
            }
        }
    }
    
    func setupView(person: Person) {
        self.nameLbl.text = person.name
        self.heightLbl.text = person.height
        self.massLbl.text = person.mass
        self.hairLbl.text = person.hair
        self.birthYearLbl.text = person.birthYear
        self.genderLbl.text = person.gender
        
        if person.homeworldUrl.isEmpty {
            homeworldBtn.isEnabled = false
        } else {
            homeworldBtn.isEnabled = true
        }
        
        if person.vehicleUrls.isEmpty {
            vehiclesBtn.isEnabled = false
        } else {
            vehiclesBtn.isEnabled = true
        }
        
        homeworldBtn.isEnabled = !person.homeworldUrl.isEmpty
        vehiclesBtn.isEnabled = !person.vehicleUrls.isEmpty
        starshipsBtn.isEnabled = !person.starshipUrls.isEmpty
        filmsBtn.isEnabled = !person.filmUrls.isEmpty
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        /// destinationは varでしか定義出来ない
        /// destinationをPersonProtocol型で定義すると遷移先にもPersonProtocolに準拠させる必要がある。
        if var destination = segue.destination as? PersonProtocol {
            destination.person = person
        }
//        switch segue.identifier {
//        case Segue.homeworld.rawValue:
//            if let destination = segue.destination as? HomeworldVC {
//                /// 値渡し
//                destination.person = person
//            }
//        case Segue.vehicles.rawValue:
//            if let destination = segue.destination as? VehiclesVC {
//                destination.person = person
//            }
//        case Segue.starships.rawValue:
//            if let destination = segue.destination as? StarshipsVC {
//                destination.person = person
//            }
//        case Segue.films.rawValue:
//            if let destination = segue.destination as? FilmsVC {
//                destination.person = person
//            }
//        default:
//            break
//        }
        
    }
    
//    enum Segue : String {
//        case homeworld = "toHomeworld"
//        case vehicles = "toVehicles"
//        case starships = "toStarships"
//        case films = "toFilms"
//    }
    
}

protocol PersonProtocol {
    /// プロトコルの変数には必ず型とアクセスレベルをつけなければいけない
    var person: Person! { get set }
}
