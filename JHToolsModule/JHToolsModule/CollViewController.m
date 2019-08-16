//
//  CollViewController.m
//  JHToolsModule
//
//  Created by 张金虎 on 2019/8/16.
//  Copyright © 2019 HU. All rights reserved.
//

#import "CollViewController.h"

@interface CollViewController ()

@end

@implementation CollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     // Do any additional setup after loading the view.
    
    self.flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-60)/4, (SCREEN_WIDTH-60)/4);
    [self.mainDataArr addObject:@"1"];
    [self.mainDataArr addObject:@"1"];
    [self.mainDataArr addObject:@"1"];
    [self.mainDataArr addObject:@"1"];
    [self.mainDataArr addObject:@"1"];
    [self.mainDataArr addObject:@"1"];
    
    [self.collectionView reloadData];
    
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_top).offset((SCREEN_WIDTH-60)/4+20);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
