//
//  Dock.m
//  QZone-HD
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "Dock.h"
#import "IconView.h"
#import "MenuBar.h"
#import "ComposeBar.h"
#import "AccountTool.h"

@interface Dock()
{
    IconView *_icon; // 头像
    MenuBar *_menu; // 菜单条
    ComposeBar *_compose; // 编辑条
    UIImageView *_divider; // 分隔线
}
@end

@implementation Dock

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.添加头像
        _icon = [[IconView alloc] init];
        _icon.account = [AccountTool sharedAccountTool].currentAccount;
        [_icon addTarget:self action:@selector(clickIcon) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_icon];
        
        // 2.添加菜单条
        __unsafe_unretained Dock *dock = self;
        _menu = [[MenuBar alloc] init];
        _menu.menuClick = ^(MenuItem *item) {
            if (dock->_dockClick) {
                dock->_dockClick(item);
            }
        };
        [self addSubview:_menu];
        
        // 3.添加编辑条
        _compose = [[ComposeBar alloc] init];
        [self addSubview:_compose];
        
        // 4.添加右边的分隔线
        _divider = [[UIImageView alloc] init];
        _divider.image = [UIImage resizeImage:@"tabbar_separate_ugc_line_v.png"];
        [self addSubview:_divider];
    }
    return self;
}

- (void)clickIcon
{
    // 1.取消选中其他
    [_menu unselect];
    
    // 2.通知外界
    if (_iconClick) {
        _iconClick();
    }
}

#pragma mark 根据当前屏幕方向，调整位置和尺寸
- (void)rotateToOrientation:(UIInterfaceOrientation)orientation
{
    // 1.编辑条
    CGSize composeSize = [_compose rotateToOrientation:orientation];
    
    // 2.调整dock的宽高
    CGFloat width = composeSize.width;
    CGFloat height = CGRectGetMaxY(_compose.frame);
    self.frame = CGRectMake(0, 0, width, height);
    
    // 3.分隔线
    _divider.frame = CGRectMake(width, 0, 2, height);
    
    // 4.菜单
    [_menu rotateToOrientation:orientation composeY:_compose.frame.origin.y];
    
    // 5.头像
    _icon.frame = CGRectMake(0, 0, width, width);
}
@end