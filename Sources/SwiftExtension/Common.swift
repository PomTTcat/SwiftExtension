//
//  Common.swift
//  SwiftExtension
//
//  Created by PomCat on 2021/3/19.
//

import Foundation
import UIKit


// MARK: - number
/// 屏幕底部安全高度
public let kSafeBottomHeight: CGFloat = UIScreen.isiPhoneXMore ? 34 : 0
/// 导航栏高度
public let kNavigationbarHeight: CGFloat = UIScreen.isiPhoneXMore ? 88 : 64
/// 状态栏高度
public let kStatubarHeight: CGFloat = UIScreen.isiPhoneXMore ? 44 : 20
/// Tabbar高度
public let kTabbarHeight:  CGFloat = 49
/// 屏幕的高（旋转屏幕有效）
public let kScreenHeight = UIScreen.kHeight
/// 屏幕的宽（旋转屏幕有效）

public let kScreenWidth = UIScreen.kWidth

/// 屏幕的Bounds
public let kScreenBounds = UIScreen.main.bounds

public let kMaxPhoneNumberLength = 11

