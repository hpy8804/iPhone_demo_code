//
//  SegmentView.m
//  QZone-HD
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "SegmentView.h"
#import "UnhighlightBtn.h"

#define kSegmentHeight 30
#define kSegmentWidth 90
#define kTitleFont [UIFont systemFontOfSize:14]

@interface SegmentView()
{
    UIButton *_currentBtn;
}
@end

@implementation SegmentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setTitles:(NSArray *)titles
{
    int count = titles.count;
    if (count <= 1) return;
    
    _titles = titles;
    
    // 1.清除以前的所有子控件
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // 2.添加新的子控件
    for (int i = 0; i<count; i++) {
        UIButton *btn = [UnhighlightBtn buttonWithType:UIButtonTypeCustom];
        // 设置背景
        [self setBtnBg:btn index:i count:count];
        // 设置宽高
        btn.frame = CGRectMake(kSegmentWidth * i, 0, kSegmentWidth, kSegmentHeight);
        // 监听
        [btn addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventTouchDown];
        // 设置文字
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        btn.titleLabel.font = kTitleFont;
        // 颜色
        [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        [self addSubview:btn];
    }
    
    // 3.自己的宽高
    self.bounds = (CGRect){CGPointZero, {kSegmentWidth * count, kSegmentHeight}};
}

#pragma mark 设置按钮背景
- (void)setBtnBg:(UIButton *)btn index:(int)index count:(int)count
{
    // 设置图片
    NSString *normal = nil;
    NSString *selected = nil;
    if (index == 0) {
        normal = @"SegmentedControl_Left_Normal.png";
        selected = @"SegmentedControl_Left_Selected.png";
        [self segClick:btn];
    } else if (index == count - 1) {
        normal = @"SegmentedControl_Right_Normal.png";
        selected = @"SegmentedControl_Right_Selected.png";
    } else {
        normal = @"SegmentedControl_Normal.png";
        selected = @"SegmentedControl_Selected.png";
    }
    [btn setBackgroundImage:[UIImage resizeImage:normal] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage resizeImage:selected] forState:UIControlStateSelected];
}

#pragma mark 点击事件
- (void)segClick:(UIButton *)btn
{
    _currentBtn.selected = NO;
    
    btn.selected = YES;
    
    _currentBtn = btn;
}
@end