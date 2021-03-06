//
//  DuckButton.swift
//  Duck App
//
//  Created by Austin Mills on 2/25/17.
//  Copyright © 2017 Austin Mills. All rights reserved.
//

import Foundation
import UIKit

class duckButton: UIButton {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 10
        self.tintColor = UIColor.black
        self.backgroundColor = UIColor.clear
    }
    
}
