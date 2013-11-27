//
//  MenuBar.h
//  QZone-HD
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuItem;
@interface MenuBar : UIView
- (void)rotateToOrientation:(UIInterfaceOrientation)orientation composeY:(CGFloat)composeY;

@property (nonatomic, copy) void (^menuClick)(MenuItem *item);

- (void)unselect;
@end
