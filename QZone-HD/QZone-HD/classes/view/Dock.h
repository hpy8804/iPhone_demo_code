//
//  Dock.h
//  QZone-HD
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuItem;
@interface Dock : UIView
- (void)rotateToOrientation:(UIInterfaceOrientation)orientation;

@property (nonatomic, copy) void (^dockClick)(MenuItem *item);
@property (nonatomic, copy) void (^iconClick)();
@end