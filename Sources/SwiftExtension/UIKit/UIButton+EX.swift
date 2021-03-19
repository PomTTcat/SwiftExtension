//
//  UIButton.swift
//  hrloo
//
//  Created by PomCat on 2020/7/1.
//  PomCat
//

import Foundation
import UIKit


public extension UIButton {
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
    
    func setBackgroundColor(_ color: UIColor?, for state: UIControl.State) {
        if let c = color {
            setBackgroundImage(UIImage.from(color: c), for: state)
        }
    }
    

}
