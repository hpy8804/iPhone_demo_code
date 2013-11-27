//
//  ComposeBar.m
//  QZone-HD
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "ComposeBar.h"
#import "MenuItem.h"

@interface ComposeBar()
{
    NSArray *_menuItems;
    NSMutableArray *_btns; // 所有的按钮
    NSMutableArray *_dividers; // 所有的分隔线
}
@end

@implementation ComposeBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.初始化items
        [self addMenuItems];
        
        // 2.添加按钮
        [self addBtns];
    }
    return self;
}

#pragma mark 初始化Item
- (void)addMenuItems
{
    _menuItems = @[
                   [MenuItem itemWithIcon:@"tabbar_mood.png"],
                   [MenuItem itemWithIcon:@"tabbar_photo.png"],
                   [MenuItem itemWithIcon:@"tabbar_blog.png"]
                   ];
}

#pragma mark 添加按钮
- (void)addBtns
{
    _btns = [NSMutableArray array];
    _dividers = [NSMutableArray array];
    
    int count = _menuItems.count;
    for (int i = 0; i<count; i++) {
        MenuItem *item = _menuItems[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:item.icon] forState:UIControlStateNormal];
        [self addSubview:btn];
        [_btns addObject:btn];
        
        if (count != i + 1) { // 添加分隔线
            UIImageView *divider = [[UIImageView alloc] init];
            divider.image = [UIImage resizeImage:@"tabbar_separate_ugc_line_v.png"];
            [self addSubview:divider];
            [_dividers addObject:divider];
        }
    }
}

- (CGSize)rotateToOrientation:(UIInterfaceOrientation)orientation
{
    int btnCount = _btns.count;
    CGFloat height = 0;
    CGFloat width = 0;
    
    if (UIInterfaceOrientationIsLandscape(orientation)) { // 横屏
        // 1.自己的frame
        height = kDockComposeBtnHeightL;
        width = kDockComposeBtnWidthL * btnCount;
        
        // 2.显示分隔线
        int dCount = _dividers.count;
        for (int i = 0; i<dCount; i++) {
            UIImageView *d = _dividers[i];
            d.hidden = NO;
            CGFloat dX = (i + 1) * kDockComposeBtnWidthL;
            d.frame = CGRectMake(dX, 0, 2, kDockComposeBtnHeightL);
        }
        
        // 3.按钮的位置
        for (int i = 0; i<btnCount; i++) {
            UIButton *btn = _btns[i];
            CGFloat btnX = i * kDockComposeBtnWidthL;
            btn.frame = CGRectMake(btnX, 0, kDockComposeBtnWidthL, kDockComposeBtnHeightL);
        }
    } else { // 竖屏
        // 1.自己的frame
        height = kDockComposeBtnHeightP * btnCount;
        width = kDockComposeBtnWidthP;
        
        // 2.隐藏分隔线
        for (UIImageView *d in _dividers) {
            d.hidden = YES;
        }
        
        // 3.按钮的位置
        for (int i = 0; i<btnCount; i++) {
            UIButton *btn = _btns[i];
            CGFloat btnY = i * kDockComposeBtnHeightP;
            btn.frame = CGRectMake(0, btnY, kDockComposeBtnWidthP, kDockComposeBtnHeightP);
        }
    }
    
    CGFloat y = kScreenHeight(orientation) - height;
    self.frame = CGRectMake(0, y, width, height);
    return CGSizeMake(width, height);
}
@end
