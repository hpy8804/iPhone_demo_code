//
//  HBAnimationUtil.h
//  MyTest
//
//  Created by weqia on 13-8-20.
//  Copyright (c) 2013年 weqia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImage+HBClass.h"

#define IMAGEVIEW_TAG  1000

@interface HBAnimationUtil : NSObject
{
    UIView * _backView;        // 背景窗口
}


+(HBAnimationUtil*)shareAnimation;

-(void) showBigImage:(UIImage*)image fromView:(UIImageView*)fromView  complete:(void(^)(UIView *bacView))complete;

-(void) goBackToView:(UIImageView*)toView withImage:(UIImage*)image;

@end
