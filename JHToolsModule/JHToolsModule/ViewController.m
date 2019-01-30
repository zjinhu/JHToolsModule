//
//  ViewController.m
//  JHToolsModule
//
//  Created by HU on 2018/7/17.
//  Copyright © 2018年 HU. All rights reserved.
//

#import "ViewController.h"
#import "JHToolsModule.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
    [UIButton masButtonWithTitle:@"back"
                      titleColor:[UIColor redColor]
                       backColor:[UIColor grayColor]
                        fontSize:13
                    cornerRadius:2
                         supView:self.view
                     constraints:^(MASConstraintMaker *make) {
                         make.centerX.mas_equalTo(self.view.mas_centerX);
                         make.top.mas_equalTo(100);
                         make.size.mas_equalTo(CGSizeMake(100, 50));
                     }
                         touchUp:^(id sender) {
                             NSLog(@"12312312312");
                         }];
    [UIImageView masImageViewWithImage:[UIImage loadImageNamed:@"refresh_loop_0"] SuperView:self.view constraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(200);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
