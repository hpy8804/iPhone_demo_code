//
//  MenuBtn.m
//  QZone-HD
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MenuBtn.h"

@interface MenuBtn()
{
    UIImageView *_divider;
}
@end

@implementation MenuBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.adjustsImageWhenHighlighted = NO;
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        [self setBackgroundImage:[UIImage resizeImage:@"tabbar_separate_selected_bg.png"] forState:UIControlStateSelected];
        
        // 分隔线
        _divider = [[UIImageView alloc] initWithImage:[UIImage resizeImage:@"tabbar_separate_line.png"]];
        _divider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        CGFloat height = 2;
        CGFloat y = frame.size.height;
        _divider.frame = CGRectMake(0, y, 0, height);
        [self addSubview:_divider];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    _divider.hidden = selected;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat width = contentRect.size.height;
    CGFloat height = width;
    return CGRectMake(0, 0, width, height);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat x = contentRect.size.height;
    CGFloat width = contentRect.size.width - x;
    CGFloat height = x;
    return CGRectMake(x, 0, width, height);
}
@end