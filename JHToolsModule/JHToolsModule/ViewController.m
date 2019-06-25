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
//    JHBaseTableView *tableView = [JHBaseTableView new];
//    [self.view addSubview:tableView];
//    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.top.equalTo(self.view);
//    }];
//
//    tableView.setCountOfRowsInSection = ^CGFloat(NSUInteger section) {
//        return 20;
//    };
//    [JHBaseTableViewCell registerCell:tableView];
//
//    tableView.setCellAtIndexPath = ^JHBaseTableViewCell *(NSIndexPath *indexPath, UITableView *tableView) {
//        JHBaseTableViewCell *cell = [JHBaseTableViewCell dequeueReusableCell:tableView];
//        cell.textLabel.text = [NSString stringWithFormat:@"text%zd",indexPath.row];
//        return cell;
//    };

    [UIImageView masImageViewWithImage:[self blureImage:[UIImage imageNamed:@"2"] withInputRadius:10] SuperView:self.view constraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(500);
        make.size.mas_equalTo(CGSizeMake(700, 440));
    }];
    [UIImageView masImageViewWithImage:[UIImage imageNamed:@"2"] SuperView:self.view constraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(450);
        make.size.mas_equalTo(CGSizeMake(700, 440));
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)blureImage:(UIImage *)originImage withInputRadius:(CGFloat)inputRadius{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *image = [CIImage imageWithCGImage:originImage.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:image forKey:kCIInputImageKey];
    [filter setValue:@(inputRadius) forKey: @"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage = [context createCGImage: result fromRect:[result extent]];
    UIImage * blurImage = [UIImage imageWithCGImage:outImage];
    return blurImage;
}
@end
