//
//  UIStoryboard+EX.swift
//  SwiftExtension
//
//  Created by PomCat on 2021/3/19.
//

import UIKit

public extension UIStoryboard {
    // let v = UIStoryboard.hrInstantiateViewController(withClass: xx.self) as! xx
    static func JJInstantiateViewController(withClass cls: AnyClass) -> UIViewController? {
        let n = String(describing: cls.self)
        let s = UIStoryboard(name: n, bundle: nil)
        return s.instantiateInitialViewController()
    }
}
