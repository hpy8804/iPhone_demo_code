//
//  UIBarButtonItem+Addition.m
//  weibo
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "UIBarButtonItem+Addition.h"

@implementation UIBarButtonItem (Addition)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action name:(NSString *)name {
    UIButton *btn = [[UIButton alloc] init];
    if (target && action) {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    [btn setAllStateBackgound:name];
    btn.bounds = (CGRect){CGPointZero, {30, 30}};
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
