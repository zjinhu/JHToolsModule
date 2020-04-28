//
//  JHTabBarItemContainer.swift
//  JHTabBarController
//
//  Created by iOS on 2020/4/28.
//  Copyright © 2020 36kr. All rights reserved.
//
import UIKit
internal class JHTabBarItemContainer: UIControl {
    private var _isSelected: Bool = false
    public override var isSelected: Bool {
        get {
            return _isSelected
        }
        set {
            guard newValue != _isSelected else {
                return
            }
            if newValue {
                select(animated: false)
            } else {
                deselect(animated: false)
            }
        }
    }
    
    func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            select(animated: animated)
        } else {
            deselect(animated: animated)
        }
    }
    
    func select(animated: Bool = true) {
  
        _isSelected = true
        
        subviews.forEach { (subview) in
            if let sub = subview as? JHTabBarItemContentView {
                sub.select(animated: animated)
            }
        }
        
    }
    
    func deselect(animated: Bool = true) {
 
        _isSelected = false
        subviews.forEach { (subview) in
            if let sub = subview as? JHTabBarItemContentView {
                sub.deselect(animated: animated)
            }
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        subviews.forEach { (subview) in
            if let sub = subview as? JHTabBarItemContentView {
                sub.snp.makeConstraints { (make) in
                    make.edges.equalToSuperview()
                }
                subview.setNeedsLayout()
            }
        }
        
    }
}
