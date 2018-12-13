//
//  JHToolsModule.h
//  JHToolsModule
//
//  Created by HU on 2018/7/19.
//  Copyright © 2018年 HU. All rights reserved.
//

#ifndef JHToolsModule_h
#define JHToolsModule_h
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#if __has_include(<JHToolsModule/JHToolsModule.h>)

#import <JHToolsModule/EdgeInsetsLabel.h>
#import <JHToolsModule/JHBaseViewController.h>
#import <JHToolsModule/JHBaseTableViewController.h>
#import <JHToolsModule/JHBaseWebViewController.h>
#import <JHToolsModule/JHToolsDefine.h>
#import <JHToolsModule/BaseUI.h>
#import <JHToolsModule/SafeEX.h>
#import <JHToolsModule/MasonryUI.h>
#import <JHToolsModule/UIButton+Position.h>
#import <JHToolsModule/NSObject+BlockSEL.h>
#import <JHToolsModule/UIControl+Block.h>
#import <JHToolsModule/NLog.h>
#import <JHToolsModule/EasyShow.h>
#import <JHToolsModule/GPSLocationManager.h>
#import <JHToolsModule/UILineView.h>
#import <JHToolsModule/UserDefaults.h>
#import <JHToolsModule/NSArray+Sudoku.h>

#else
#import "EdgeInsetsLabel.h"
#import "JHBaseViewController.h"
#import "JHBaseTableViewController.h"
#import "JHBaseWebViewController.h"
#import "JHToolsDefine.h"
#import "BaseUI.h"
#import "SafeEX.h"
#import "MasonryUI.h"
#import "UIButton+Position.h"
#import "NSObject+BlockSEL.h"
#import "UIControl+Block.h"
#import "NLog.h"
#import "EasyShow.h"
#import "GPSLocationManager.h"
#import "UILineView.h"
#import "UserDefaults.h"
#import "NSArray+Sudoku.h"
#endif


#endif /* JHToolsModule_h */
