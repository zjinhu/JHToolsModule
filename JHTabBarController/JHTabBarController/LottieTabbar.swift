//
//  Lottie.swift
//  PupilGuard
//
//  Created by iOS on 2020/4/21.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit
import Lottie
import ESTabBarController_swift
import SnapKit
class BaseContentView: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = UIColor.init(named: "tab_color_text_nor")!
        highlightTextColor = UIColor.init(named: "tab_color_text_hi")!
        iconColor = UIColor.init(named: "tab_color_icon_nor")!
        highlightIconColor = UIColor.init(named: "tab_color_icon_hi")!
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class LottieContentView: BaseContentView {

    let lottieView: AnimationView = {
        let lottieView = AnimationView()
        lottieView.contentMode = .scaleAspectFit
        return lottieView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        changeLottieView()
        addSubview(lottieView)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateLayout() {
        super.updateLayout()
        
        lottieView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }
    
    override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        super.selectAnimation(animated: animated, completion: nil)
        lottieView.play()
    }
    
    override func deselectAnimation(animated: Bool, completion: (() -> ())?) {
        super.deselectAnimation(animated: animated, completion: nil) 
        lottieView.stop()
    }

    override func reselectAnimation(animated: Bool, completion: (() -> ())?) {
        super.reselectAnimation(animated: animated, completion: nil)
        lottieView.play()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                // 适配代码
                changeLottieView()
            }
        } else {
            // Fallback on earlier versions
        }
    }
 
    func changeLottieView() {
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                // Dark
                let animation = Animation.named("02")
                lottieView.animation = animation
            } else {
                // Light
                let animation = Animation.named("01")
                lottieView.animation = animation
            }
        } else {
            let animation = Animation.named("01")
            lottieView.animation = animation
        }
    }
}
