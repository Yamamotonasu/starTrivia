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
    
    var personApi = PersonApi()
    override func viewDidLoad() {
        super.viewDidLoad()
        // step1: makenetworking request
    }

    @IBAction func randomClicked(_ sender: Any) {
        let random = Int.random(in: 1...87)
        personApi.getRandomPersonUrlSessionAlamo(id: random) { (person) in
            if let person = person {
                /// クロージャの中に居る場合自分の所属しているクラスにアクセスする場合、selfを付ける必要がある
                self.nameLbl.text = person.name
                self.heightLbl.text = person.height
                self.massLbl.text = person.mass
                self.hairLbl.text = person.hair
                self.birthYearLbl.text = person.birthYear
                self.genderLbl.text = person.gender
            }
        }
    }
    
}

