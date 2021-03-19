//
//  UINavigationController+EX.swift
//  haZip
//
//  Created by PomCat on 2021/1/20.
//  PomCat
//

import Foundation
import UIKit

public extension UINavigationController {
    func popAndPush(popNumber:Int, _ viewController: UIViewController) {

        if popNumber == 0 {
            pushViewController(viewController, animated: true)
            return
        }
        
        var newVCs: [UIViewController] = []

        for v in viewControllers {
            newVCs.append(v)
        }
        for _ in 1...popNumber {
            newVCs.removeLast()
        }

        newVCs.append(viewController)
        setViewControllers(newVCs, animated: true)

    }
    
    func clearViewController(clsName: String) {

        var newVCs: [UIViewController] = []
        for vc in viewControllers {
            if vc.hrTypeName != clsName {
                newVCs.append(vc)
            }
        }
        
        setViewControllers(newVCs, animated: false)
    }
    
    func clearViewControllerAndPush(clsName: String, _ viewController: UIViewController) {

        var newVCs: [UIViewController] = []
        for vc in viewControllers {
            if vc.hrTypeName != clsName {
                newVCs.append(vc)
            }
        }
        newVCs.append(viewController)
        setViewControllers(newVCs, animated: true)
    }
    
}
