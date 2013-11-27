//
//  SegmentView.h
//  QZone-HD
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentView : UIView
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) NSUInteger selectedIndex;
@end