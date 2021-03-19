//
//  NSObject+addition.swift
//  hrloo
//
//  Created by PomCat on 2020/6/20.
//  PomCat
//

import Foundation
import UIKit

public extension NSObjectProtocol where Self : UIViewController {

}


public extension NSObject {
    
    /*
     print(UIButton.hrTypeName)
     print(UIButton().hrTypeName)
     print(UIButton().hrOtherTypeName)
     
     UIButton
     UIButton
     UIButton
     */
    
    // Instance Level
    var hrTypeName: String {
        return String(describing: Self.self)
    }

    // Instance Level - Alternative Way
    var hrOtherTypeName: String {
        let thisType = type(of: self)
        return String(describing: thisType)
    }

    // Type Level
    static var hrTypeName: String {
        return String(describing: Self.self)
    }
}
