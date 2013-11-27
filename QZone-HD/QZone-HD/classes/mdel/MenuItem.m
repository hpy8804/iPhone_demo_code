//
//  MenuItem.m
//  QZone-HD
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MenuItem.h"

@implementation MenuItem
+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title className:(NSString *)className modal:(BOOL)modal
{
    MenuItem *item = [[MenuItem alloc] init];
    item.icon = icon;
    item.title = title;
    item.className = className;
    item.modal = modal;
    return item;
}
+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title className:(NSString *)className
{
    return [self itemWithIcon:icon title:title className:className modal:NO];
}

+ (id)itemWithIcon:(NSString *)icon
{
    return [self itemWithIcon:icon title:nil className:nil modal:NO];
}
@end
