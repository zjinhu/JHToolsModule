//
//  JHBaseTableViewCell.h
//  JHToolsModule
//
//  Created by 狄烨 . on 2019/1/22.
//  Copyright © 2019 HU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHBaseTableViewCell : UITableViewCell

- (void)setUpCellViews;//初始化cell 视图

- (void)setCellModel:(id)model atIndexPath:(NSIndexPath *)indexPath;//设置cell model

- (CGFloat)setCellWithModel:(id)model atIndexPath:(NSIndexPath *)indexPath;//设置cell model并拿到cell高度

#pragma mark - register cell tools

+ (void)registerClassToTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;

+ (void)registerClassToTableView:(UITableView *)tableView;

@end

