//
//  BoxButton.swift
//  GoForGold
//
//  Created by Christopher Walter on 7/21/18.
//  Copyright © 2018 AssistStat. All rights reserved.
//

import UIKit

class BoxButton: UIButton {

    var value: Int
    var isOpen: Bool {
        didSet {
            if isOpen == true {
                self.isEnabled = false
                if value == 0 {
                    self.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
                    self.setTitle("X", for: .normal)
                } else {
                    self.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
                    self.setTitle("\(value)", for: .normal)
                }
            } else {
                self.backgroundColor = #colorLiteral(red: 0.4078431373, green: 0.7333333333, blue: 0.4352941176, alpha: 1)
                self.setTitle("?", for: .normal)
                self.isEnabled = true
                resetBoxDesign()
            }
        }
    }
    

    required init?(coder aDecoder: NSCoder) {
        value = 0
        isOpen = false
        super.init(coder: aDecoder)
        resetBoxDesign()
    }
    func resetBoxDesign() {
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitle("?", for: .normal)
        self.layer.cornerRadius = 20.0
        self.layer.borderWidth = 5.0
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    

}
