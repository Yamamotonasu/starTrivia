//
//  StarshipsVC.swift
//  StarTrivia
//
//  Created by 山本裕太 on 2019/06/24.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit

class StarshipsVC: UIViewController, PersonProtocol {
    
    ///UIviews
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var modelLbl: UILabel!
    @IBOutlet weak var makerLbl: UILabel!
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var lengthLbl: UILabel!
    @IBOutlet weak var speedLbl: UILabel!
    @IBOutlet weak var crewLbl: UILabel!
    @IBOutlet weak var driveLbl: UILabel!
    @IBOutlet weak var previousBtn: FadeEnabledBtn!
    @IBOutlet weak var nextBtn: FadeEnabledBtn!
    
    
    var person: Person!
    /// starshipをインスタンス化
    let api = StarshipApi()
    /// apiの取得結果を入れる空の配列を準備
    var starships = [String]()
    /// 現在のindex番号
    var currentStarship = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        /// 宇宙船のURLの配列を取得する
        starships = person.starshipUrls
        nextBtn.isEnabled = starships.count > 1
        previousBtn.isEnabled = false
        /// viewをロードした時は必ず最初のurlを叩くようにする
        guard let firstStarship = starships.first else { return }
        getStarship(url: firstStarship)
        
    }
    
    func getStarship(url: String) {
        api.getStarship(url: url) { (starship) in
            if let starship = starship {
                self.setupView(starship: starship)
            }
        }
    }
    
    func setupView(starship: Starship) {
        nameLbl.text = starship.name
        modelLbl.text = starship.model
        makerLbl.text = starship.manufacturer
        costLbl.text = starship.cost
        lengthLbl.text = starship.length
        speedLbl.text = starship.speed
        crewLbl.text = starship.crew
        driveLbl.text = starship.drive
    }
    
    
    @IBAction func PreviousCliked(_ sender: Any) {
        currentStarship -= 1
        setButtonState()
    }
    @IBAction func nextClicked(_ sender: Any) {
        currentStarship += 1
        setButtonState()
    }
    
    func setButtonState() {
        nextBtn.isEnabled = currentStarship == starships.count - 1 ? false : true
        previousBtn.isEnabled = currentStarship == 0 ? false : true
        
        /// ボタンを押したら新しいtextを挿入する
        getStarship(url: starships[currentStarship])
    }
    

}
