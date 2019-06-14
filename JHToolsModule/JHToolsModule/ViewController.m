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

    [[GPSLocationManager shared] startLocationAndCompletion:^(CLLocation *location, NSError *error) {
        
        [[GPSLocationManager shared] stop];
    }];
    JHBaseTableView *tableView = [JHBaseTableView new];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
    }];
 
    tableView.setCountOfRowsInSection = ^CGFloat(NSUInteger section) {
        return 20;
    };
    [JHBaseTableViewCell registerCell:tableView];
    
    tableView.setCellAtIndexPath = ^JHBaseTableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
        JHBaseTableViewCell *cell = [JHBaseTableViewCell dequeueReusableCell:tableView];
        cell.textLabel.text = [NSString stringWithFormat:@"text%zd",indexPath.row];
        return cell;
    };
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
