//
//  JHTabBarItemContentView.swift
//  JHTabBarController
//
//  Created by iOS on 2020/4/28.
//  Copyright © 2020 36kr. All rights reserved.
//

import UIKit
import Lottie

open class JHTabBarItemContentView: UIView {
    
    /// 是否被选中
    open var selected = false
    
    open var title: String? {
        didSet {
            titleLabel.text = title
            //             self.updateLayout()
        }
    }
    
    open var image: UIImage? {
        didSet {
            if !selected { updateDisplay() }
        }
    }
    
    open var selectedImage: UIImage? {
        didSet {
            if selected { updateDisplay() }
        }
    }
    
    open var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
 
    open var renderingMode: UIImage.RenderingMode = .alwaysTemplate {
        didSet { updateDisplay() }
    }
    
    lazy var lottieView: AnimationView = {
        let view = AnimationView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    open var titleLabel : UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return view
    }()
    
    open var conView: UIView = {
        let view = UIView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureSubviews()
    }
    
    init(_ lottieName: String) {
        super.init(frame: .zero)
        configureSubviews()
        imageView.isHidden = true
        lottieView.animation = Animation.named(lottieName)
    }
    
    private var selectedColor: UIColor{
        return UITabBar.appearance().tintColor
    }

    private var unselectedColor: UIColor?{
        return UITabBar.appearance().unselectedItemTintColor
    }
    
    open func configureSubviews() {
        self.isUserInteractionEnabled = false
 
        addSubview(conView)
        conView.addSubview(titleLabel)
        conView.addSubview(imageView)
        conView.addSubview(lottieView)
        titleLabel.textColor = unselectedColor
        imageView.tintColor = unselectedColor
    }
    
    open func updateDisplay() {
        imageView.image = (selected ? (selectedImage ?? image) : image)?.withRenderingMode(renderingMode)
        imageView.tintColor = selected ? selectedColor : unselectedColor
        titleLabel.textColor = selected ? selectedColor : unselectedColor
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        lottieView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        conView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview()
        }
    }

    func select(animated: Bool = true) {
        selected = true
        lottieView.play()
        updateDisplay()
    }
    
    func deselect(animated: Bool = true) {
        selected = false
        lottieView.stop()
        updateDisplay()
    }

    open func selectAnimation(animated: Bool) {

    }
    
    open func deselectAnimation(animated: Bool) {

    }
    
    open func reselectAnimation(animated: Bool) {
        
    }
}
