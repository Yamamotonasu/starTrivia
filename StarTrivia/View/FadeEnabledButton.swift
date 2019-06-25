//
//  FadeEnabledButton.swift
//  StarTrivia
//
//  Created by 山本裕太 on 2019/06/23.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit

class FadeEnabledBtn: UIButton {
    /// ボタンにアニメーションを付けるcustom class
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                UIView.animate(withDuration: 0.2) {
                    self.alpha = 1.0
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.alpha = 0.5
                }
            }
        }
    }
}
