//
//  JHTabBarController.swift
//  JHTabBarController
//
//  Created by iOS on 2020/4/28.
//  Copyright © 2020 36kr. All rights reserved.
//

import UIKit
 
public class JHTabBarController:  UITabBarController {
    fileprivate var shouldSelectOnTabBar = true

    open override var selectedViewController: UIViewController? {
        willSet {
            guard shouldSelectOnTabBar,
                  let newValue = newValue else {
                shouldSelectOnTabBar = true
                return
            }
            guard let tabBar = tabBar as? JHTabBar, let index = viewControllers?.firstIndex(of: newValue) else {
                return
            }
            tabBar.select(itemAt: index, animated: false)
        }
    }

    open override var selectedIndex: Int {
        willSet {
            guard shouldSelectOnTabBar else {
                shouldSelectOnTabBar = true
                return
            }
            guard let tabBar = tabBar as? JHTabBar else {
                return
            }
            tabBar.select(itemAt: selectedIndex, animated: false)
        }
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        guard self.tabBar as? JHTabBar == nil else {
            return
        }
        let tabBar = JHTabBar()
        if let barTint = self.tabBar.barTintColor {
            tabBar.barTintColor = barTint
        }

        self.setValue(tabBar, forKey: "tabBar")
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    open var barHeight: CGFloat {
        get {
            return (tabBar as? JHTabBar)?.barHeight ?? tabBar.frame.height
        }
        set {
            (tabBar as? JHTabBar)?.barHeight = newValue
        }
    }
    
    private func updateTabBarFrame() {
        var tabFrame = tabBar.frame
        if #available(iOS 11.0, *) {
            tabFrame.size.height = barHeight + view.safeAreaInsets.bottom
        } else {
            tabFrame.size.height = barHeight
        }
        tabFrame.origin.y = self.view.frame.size.height - tabFrame.size.height
        tabBar.frame = tabFrame
        tabBar.setNeedsLayout()
    }
    
    @available(iOS 11.0, *)
    open override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        updateTabBarFrame()
    }

    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let idx = tabBar.items?.firstIndex(of: item) else {
            return
        }
        print("dianji \(idx)")
        if let controller = viewControllers?[idx] {
            shouldSelectOnTabBar = false
            selectedIndex = idx
            delegate?.tabBarController?(self, didSelect: controller)
        }
    }
}
 
