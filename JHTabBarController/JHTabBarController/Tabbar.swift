//
//  Tabbar.swift
//  PupilGuard
//
//  Created by iOS on 2020/4/21.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import ESTabBarController_swift

class Tabbar {
    
    static func lottieSytle() -> ESTabBarController {
        
        
        let tabBarController = ESTabBarController()

        let v1 = HabitVC()
        let v2 = CountDownVC()
        let v3 = MineVC()
        
        let item1 = ESTabBarItem.init(BaseContentView(), title: "1", image: UIImage(named: "tab_home_nor"), selectedImage: UIImage(named: "tab_home_hi"))
        let item2 = ESTabBarItem.init(BaseContentView(), title: nil, image: UIImage(named: "tab_chat_nor"), selectedImage: UIImage(named: "tab_chat_hi"))
        let item3 = ESTabBarItem.init(LottieContentView(), title: nil, image: nil, selectedImage: nil)
        
        v1.tabBarItem = item1
        v2.tabBarItem = item2
        v3.tabBarItem = item3
        
        let nav1 = UINavigationController.init(rootViewController: v1)
        let nav2 = UINavigationController.init(rootViewController: v2)
        let nav3 = UINavigationController.init(rootViewController: v3)
        
        tabBarController.viewControllers = [nav1, nav2, nav3]
        
        return tabBarController
    }
}
