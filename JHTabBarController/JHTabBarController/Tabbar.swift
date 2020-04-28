//
//  Tabbar.swift
//  PupilGuard
//
//  Created by iOS on 2020/4/21.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import UIKit
class Tabbar {
    
    static func lottieSytle() -> JHTabBarController {
        
        
        let testController = JHTabBarController()
        let vc1 = ViewController()
        vc1.view.backgroundColor = .gray
        vc1.tabBarItem = JHTabBarItem.init( title: "1", image: UIImage(named: "icon1_unselected")!, selectedImage: UIImage(named: "icon1_selected")!)
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .black
        vc2.tabBarItem = JHTabBarItem.init( title: "2", image: UIImage(named: "icon2_unselected")!, selectedImage: UIImage(named: "icon2_selected")!)
        let vc3 = UIViewController()
        vc3.view.backgroundColor = .blue
        //        vc3.tabBarItem = TabBarItem.init(title: "3", image: UIImage(named: "icon3_unselected")!, selectedImage: UIImage(named: "icon3_selected")!)
        vc3.tabBarItem = JHTabBarItem.init(JHTabBarItemContentView("01"), title: "3", image: UIImage(named: "icon3_unselected")!, selectedImage: UIImage(named: "icon3_selected")!)
        
        let nav1 = UINavigationController.init(rootViewController: vc1)
        let nav2 = UINavigationController.init(rootViewController: vc2)
        let nav3 = UINavigationController.init(rootViewController: vc3)
        
        testController.viewControllers = [nav1, nav2, nav3]
        testController.selectedIndex = 2
        
        return testController
    }
}
