//
//  UIImageView+EX.swift
//  haZip
//
//  Created by PomCat on 2021/1/20.
//  PomCat
//

import Foundation
import UIKit

public extension UIImageView {
    
    convenience init(name: String) {
        self.init(image:UIImage(named: name))
    }
    
    
}
