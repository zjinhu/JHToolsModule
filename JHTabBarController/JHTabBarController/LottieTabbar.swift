//
//  Lottie.swift
//  PupilGuard
//
//  Created by iOS on 2020/4/21.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit
import Lottie 
import SnapKit
class BaseContentView: JHTabBarItemContentView {
    
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
