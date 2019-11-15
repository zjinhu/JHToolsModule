//
//  ViewController.swift
//  JHToolsModule_Swift
//
//  Created by iOS on 15/11/2019.
//  Copyright © 2019 HU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .cyan
        SLog(SCREEN_HEIGHT)
        // Do any additional setup after loading the view.
        SLog(StatusBarHeight())

    }


}

