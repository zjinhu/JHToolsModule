//
//  JHTabBar.swift
//  JHTabBarController
//
//  Created by iOS on 2020/4/28.
//  Copyright © 2020 36kr. All rights reserved.
//

import SnapKit
import UIKit
open class JHTabBar: UITabBar {
    private var buttons: [JHTabBarItemContainer] = []
    
    fileprivate var shouldSelectOnTabBar = true
    open override var selectedItem: UITabBarItem? {
        willSet {
            guard let newValue = newValue else {
                buttons.forEach { $0.setSelected(false, animated: false) }
                return
            }
            guard let index = items?.firstIndex(of: newValue),
                index != NSNotFound else {
                    return
            }
            
            select(itemAt: index, animated: false)
            
        }
    }
    
    open override var items: [UITabBarItem]? {
        didSet {
            reloadViews()
        }
    }
    
    open override func setItems(_ items: [UITabBarItem]?, animated: Bool) {
        super.setItems(items, animated: animated)
        reloadViews()
    }
    
    
    var barHeight: CGFloat = 49
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = barHeight
        if #available(iOS 11.0, *) {
            sizeThatFits.height = sizeThatFits.height + safeAreaInsets.bottom
        }
        return sizeThatFits
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        let btnWidth = bounds.width / CGFloat(buttons.count)
        var btnHeight = bounds.height
        if #available(iOS 11.0, *) {
            btnHeight -= safeAreaInsets.bottom
        }
        
        for (index, button) in buttons.enumerated() {
            button.frame = CGRect(x: btnWidth * CGFloat(index), y: 0, width: btnWidth, height: btnHeight)
            button.setNeedsLayout()
        }
    }
    
    func reloadViews() {
        subviews.filter { String(describing: type(of: $0)) == "UITabBarButton" }.forEach { $0.removeFromSuperview() }
        buttons.forEach { $0.removeFromSuperview()}
        buttons = items?.map { self.button(forItem: $0) } ?? []
        setNeedsLayout()
    }
    
    private func button(forItem item: UITabBarItem) -> JHTabBarItemContainer {
        let button = JHTabBarItemContainer()
        button.addTarget(self, action: #selector(btnPressed), for: .touchUpInside)
        if selectedItem != nil && item === selectedItem {
            button.select(animated: false)
        }
        self.addSubview(button)
        if let item = item as? JHTabBarItem, let contentView = item.contentView {
            button.addSubview(contentView)
        }
        return button
    }
    
    @objc private func btnPressed(sender: JHTabBarItemContainer) {
        guard let index = buttons.firstIndex(of: sender),
            index != NSNotFound,
            let item = items?[index] else {
                return
        }
        buttons.forEach { (button) in
            guard button != sender else {
                return
            }
            button.setSelected(false, animated: true)
        }
        sender.setSelected(true, animated: true)
        delegate?.tabBar?(self, didSelect: item)
    }
    
    func select(itemAt index: Int, animated: Bool = false) {
        guard index < buttons.count else {
            return
        }
        let selectedbutton = buttons[index]
        buttons.forEach { (button) in
            guard button != selectedbutton else {
                return
            }
            button.setSelected(false, animated: false)
        }
        selectedbutton.setSelected(true, animated: false)
    }
    
    // 红点
//    func addRedPointView(index: Int) {
//        if Thread.isMainThread {
//            self.addRedPointViewInMainThread(index: index)
//        } else {
//            DispatchQueue.main.async {
//                self.addRedPointViewInMainThread(index: index)
//            }
//        }
//    }
    
//    private func addRedPointViewInMainThread(index: Int) {
//        let redView = UIView()
//        let totalW = UIScreen.main.bounds.size.width
//        let singleW = totalW / CGFloat(self.items?.count ?? 1)
//        let x = ceil(CGFloat(index) * singleW + singleW / 2.0 + LOTAnimationViewWidth / 2.0 - 5.0)
//        let y:CGFloat = 5.0
//        redView.frame = CGRect(x: x, y: y, width: RedPointViewWidthAndHeight, height: RedPointViewWidthAndHeight)
//        redView.backgroundColor = UIColor.red
//        redView.layer.cornerRadius = RedPointViewWidthAndHeight / 2.0
//        redView.tag = 2000 + index;
//        redView.isHidden = true
//        self.addSubview(redView)
//    }
//
//    // 设置红点状态
//    public func setBadgeStatus(index: Int, isHidden: Bool, count: Int = 0) {
//        let redView = self.viewWithTag(2000 + index)
//        if isHidden {
//            redView?.isHidden = true
//            self.items?[index].badgeValue = nil
//        } else {
//            if count > 0 {
//                let badgeText = count <= 99 ? "\(count)" : "\(99)+"
//                redView?.isHidden = true
//                self.items?[index].badgeValue = isHidden == false ? badgeText : nil
//            } else {
//                redView?.isHidden = false
//                self.items?[index].badgeValue = nil
//            }
//        }
//    }

}
