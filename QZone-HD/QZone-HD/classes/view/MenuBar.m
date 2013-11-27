//
//  MenuBar.m
//  QZone-HD
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MenuBar.h"
#import "MenuItem.h"
#import "MenuBtn.h"

@interface MenuBar()
{
    NSArray *_menuItems; // 所有的模型
    UIImageView *_divider;
    
    MenuBtn *_currentBtn;
}
@end

@implementation MenuBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.初始化MenuItem
        [self addMenuItems];
        
        // 2.添加按钮
        [self addBtns];
    }
    return self;
}

#pragma mark 添加MenuItem
- (void)addMenuItems
{
    _menuItems = @[
    [MenuItem itemWithIcon:@"tab_bar_feed_icon.png" title:@"全部动态" className:@"AllStatusViewController"],
    [MenuItem itemWithIcon:@"tab_bar_passive_feed_icon.png" title:@"与我相关" className:@"AboutMeViewController"],
    [MenuItem itemWithIcon:@"tab_bar_pic_wall_icon.png" title:@"照片墙" className:@"PhotoViewController"],
    [MenuItem itemWithIcon:@"tab_bar_friend_icon.png" title:@"好友" className:@"FriendViewController"],
    [MenuItem itemWithIcon:@"tab_bar_app_icon.png" title:@"应用" className:@"AppViewController"],
    [MenuItem itemWithIcon:@"tab_bar_pic_setting_icon.png" title:@"设置" className:@"SettingViewController" modal:YES]];
}

#pragma mark 添加按钮
- (void)addBtns
{
    // 顶部的分隔线
    _divider = [[UIImageView alloc] init];
    _divider.image = [UIImage resizeImage:@"tabbar_separate_line.png"];
    _divider.frame = CGRectMake(0, 0, 0, 2);
    [self addSubview:_divider];
    
    int count = _menuItems.count;
    for (int i = 0; i<count; i++) {
        CGFloat y = i * KDockMenuBtnHeight;
        
        // 按钮
        MenuItem *item = _menuItems[i];
        MenuBtn *btn = [MenuBtn buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:item.icon] forState:UIControlStateNormal];
        btn.tag = i;
        btn.frame = CGRectMake(0, y, 0, KDockMenuBtnHeight);
        [btn setTitle:item.title forState:UIControlStateNormal];
        // 监听
        [btn addTarget:self action:@selector(menuClick:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:btn];
    }
}

#pragma mark 点击了菜单
- (void)menuClick:(MenuBtn *)btn
{
    // 最后一个按钮不要进入选中状态
    if (btn.tag != _menuItems.count - 1) {
        _currentBtn.selected = NO;
        btn.selected = YES;
        _currentBtn = btn;
    }
    
    if (_menuClick) {
        _menuClick(_menuItems[btn.tag]);
    }
}

- (void)rotateToOrientation:(UIInterfaceOrientation)orientation composeY:(CGFloat)composeY
{
    // 1.设置整个条的frame
    CGSize superSize = self.superview.frame.size;
    CGFloat width = superSize.width;
    CGFloat height = _menuItems.count * KDockMenuBtnHeight;
    CGFloat y = composeY - height;
    self.frame = CGRectMake(0, y, width, height);
    
    // 2.调整所有子控件的宽度
    NSArray *subviews = self.subviews;
    for (UIView *child in subviews) {
        CGRect childFrame = child.frame;
        childFrame.size.width = width;
        child.frame = childFrame;
    }
}

- (void)unselect
{
    _currentBtn.selected = NO;
}
@end
