//
//  JHToolsDefine.swift
//  JHToolsModule_Swift
//
//  Created by iOS on 15/11/2019.
//  Copyright © 2019 HU. All rights reserved.
//

import UIKit
import Foundation
// MARK: ===================================变量宏定义=========================================

// MARK:- 屏幕
public let SCREEN_HEIGHT = UIScreen.main.bounds.height
public let SCREEN_WIDTH = UIScreen.main.bounds.width
public let FIT_WIDTH = UIScreen.main.bounds.size.width / 375
public let FIT_HEIGHT = UIScreen.main.bounds.size.height / 667

// MARK:- 系统版本
let IOS11 = (UIDevice.current.systemVersion as NSString).doubleValue >= 11.0
let IOS12 = (UIDevice.current.systemVersion as NSString).doubleValue >= 12.0
let IOS13 = (UIDevice.current.systemVersion as NSString).doubleValue >= 13.0

func IS_IOS11() -> Bool { return (UIDevice.current.systemVersion as NSString).doubleValue >= 11.0 }
func IS_IOS12() -> Bool { return (UIDevice.current.systemVersion as NSString).doubleValue >= 12.0 }
func IS_IOS13() -> Bool { return (UIDevice.current.systemVersion as NSString).doubleValue >= 13.0 }
let systemVersion = (UIDevice.current.systemVersion as String)



func StatusBarHeight() ->CGFloat {
    if #available(iOS 13.0, *){
        let window = UIApplication.shared.windows.first
        return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }else{
        return UIApplication.shared.statusBarFrame.height
    }
}
// MARK:- 画线宽度
let Scare = UIScreen.main.scale
let LineHeight = (Scare >= 1 ? 1/Scare : 1)



// MARK:- 打印输出
func SLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\n\n<><><><><>-「LOG」-<><><><><>\n\n>>>>>>>>>>>>>>>所在类:>>>>>>>>>>>>>>>\n\n\(fileName)\n\n>>>>>>>>>>>>>>>所在行:>>>>>>>>>>>>>>>\n\n\(lineNum)\n\n>>>>>>>>>>>>>>>信 息:>>>>>>>>>>>>>>>\n\n\(message)\n\n<><><><><>-「END」-<><><><><>\n\n")
    #endif
}
