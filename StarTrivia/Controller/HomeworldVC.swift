//
//  HomeworldVC.swift
//  StarTrivia
//
//  Created by 山本裕太 on 2019/06/24.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit

class HomeworldVC: UIViewController, PersonProtocol {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var climateLbl: UILabel!
    @IBOutlet weak var terrainLbl: UILabel!
    @IBOutlet weak var populationLbl: UILabel!
    
    var person: Person!
    let api = HomeworldApi()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        api.getHomeworld(url: person.homeworldUrl) { (homeworld) in
            /// homeworldがなければメソッドを呼ばない
            if let homeworld = homeworld {
                self.setupUi(homeworld: homeworld)
            }
        }
    }
    
    /// homeworldに準拠したインスタンスを渡す
    func setupUi(homeworld: Homeworld) {
        nameLbl.text = homeworld.name
        climateLbl.text = homeworld.climate
        terrainLbl.text = homeworld.terrain
        populationLbl.text = homeworld.population
    }
}
