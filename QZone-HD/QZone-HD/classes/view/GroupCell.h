//
//  GroupCell.h
//  QZone-HD
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CellItem;
@interface GroupCell : UITableViewCell
@property (nonatomic, strong) CellItem *cellItem;
@property (nonatomic, weak) UITableView *myTableView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end