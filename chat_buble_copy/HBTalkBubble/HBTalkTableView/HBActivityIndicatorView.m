//
//  HBActivityIndicatorView.m
//  MyTest
//
//  Created by weqia on 13-8-11.
//  Copyright (c) 2013年 weqia. All rights reserved.
//

#import "HBActivityIndicatorView.h"

@implementation HBActivityIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _completeImage=[UIImage imageNamed:@"btn_check_on_check.png"];
        _waitImage=[UIImage imageNamed:@"dialog_load.png"];
    }
    return self;
}
#pragma -mark 私有方法


#pragma -mark 接口方法
-(void)startAnimating
{
    self.image=_waitImage;
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];

}
-(void)stopAnimating
{
    self.image=_completeImage;
    [self.layer removeAnimationForKey:@"rotationAnimation"];
    [UIView animateWithDuration:1 animations:^{
        self.alpha=0;
    } completion:^(BOOL finished) {
    }];
}

@end
