//
//  IconView.m
//  QZone-HD
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "IconView.h"
#import <QuartzCore/QuartzCore.h>
#import "Account.h"

#define kImageMaxCube 100
#define kTitleRatio 0.2
#define kTopMarginRatio 0.2
#define kLeftMarginRatio 0.1

@implementation IconView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.layer.cornerRadius = 5;
        self.imageView.layer.masksToBounds = YES;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setImage:[UIImage imageNamed:@"default_person_lit.png"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setAccount:(Account *)account
{
    _account = account;
    
    [self setTitle:account.qq forState:UIControlStateNormal];
}

#pragma mark - 覆盖父类的2个方法
#pragma mark 设置按钮标题的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat btnWidth = contentRect.size.width;
    if (btnWidth <= kImageMaxCube) return CGRectZero;
    
    CGFloat btnHeight = contentRect.size.height;
    CGFloat titleY = btnHeight * kTopMarginRatio + kImageMaxCube;
    CGFloat titleWidth = btnWidth;
    CGFloat titleHeight = contentRect.size.height * kTitleRatio;
//    NSLog(@"titleFrame:%@", NSStringFromCGRect(CGRectMake(0, titleY, titleWidth,  titleHeight)));
    return CGRectMake(0, titleY, titleWidth,  titleHeight);
}

#pragma mark 设置按钮图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat btnWidth = contentRect.size.width;
    CGFloat imgY = contentRect.size.height * kTopMarginRatio;
    CGFloat imgX = 0;
    CGFloat imgWidth = 0;
    if (btnWidth > kImageMaxCube) {
        imgWidth = kImageMaxCube;
        imgX = (btnWidth - imgWidth) * 0.5;
        self.titleLabel.hidden = NO;
    } else {
        self.titleLabel.hidden = YES;
        imgX = btnWidth * kLeftMarginRatio;
        imgWidth = btnWidth - 2 * imgX;
    }
    CGFloat imgHeight = imgWidth;
//    NSLog(@"imageFrame:%@", NSStringFromCGRect(CGRectMake(imgX, imgY, imgWidth, imgHeight)));
    return CGRectMake(imgX, imgY, imgWidth, imgHeight);
}
@end