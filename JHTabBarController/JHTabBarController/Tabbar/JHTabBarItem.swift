//
//  JHTabBarItem.swift
//  JHTabBarController
//
//  Created by iOS on 2020/4/28.
//  Copyright © 2020 36kr. All rights reserved.
//
 
import UIKit
open class JHTabBarItem: UITabBarItem {
    open var contentView: JHTabBarItemContentView?
    
    open override var title: String? // default is nil
        {
        didSet { self.contentView?.title = title }
    }

    open override var image: UIImage? // default is nil
        {
        didSet { self.contentView?.image = image }
    }
 
    open override var selectedImage: UIImage? // default is nil
        {
        didSet { self.contentView?.selectedImage = selectedImage }
    }
    open override var tag: Int // default is 0
        {
        didSet { self.contentView?.tag = tag }
    }

    public init(_ contentView: JHTabBarItemContentView = JHTabBarItemContentView(), title: String? = nil, image: UIImage? = nil, selectedImage: UIImage? = nil, tag: Int = 0) {
        super.init()
        self.contentView = contentView
        self.title = title
        self.image = image
        self.selectedImage = selectedImage
        self.tag = tag
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
