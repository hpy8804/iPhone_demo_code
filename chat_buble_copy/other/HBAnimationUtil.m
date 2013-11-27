//
//  HBAnimationUtil.m
//  MyTest
//
//  Created by weqia on 13-8-20.
//  Copyright (c) 2013年 weqia. All rights reserved.
//

#import "HBAnimationUtil.h"

@implementation HBAnimationUtil

+(HBAnimationUtil*)shareAnimation
{
    static HBAnimationUtil * util=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util=[[HBAnimationUtil alloc]init];
    });
    return util;
}

-(id)init
{
    self=[super init];
    if(self){
        _backView=nil;
    }
    return self;
}


#pragma -mark 接口方法
-(void) showBigImage:(UIImage*)image fromView:(UIImageView*)fromView  complete:(void(^)(UIView *bacView))complete
{
    CGRect frame;
    UIView * back=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    back.backgroundColor=[UIColor clearColor];
    [fromView.window addSubview:back];
    CGRect rect=[fromView.superview convertRect:fromView.frame toView:back];
    UIImageView * imgView=[[UIImageView alloc]initWithFrame:rect];
    [back addSubview:imgView];
    imgView.tag=IMAGEVIEW_TAG;
    _backView=back;
    if(image!=nil){
        UIImage * bigImage=[image getLimitImage:back.frame.size];
        frame=CGRectMake((back.frame.size.width-bigImage.size.width)/2, (back.frame.size.height-bigImage.size.height)/2, bigImage.size.width, bigImage.size.height);
        imgView.image=bigImage;
    }
    else{
        frame=fromView.frame;
        frame.origin.x=(back.frame.size.width-frame.size.width)/2;
        frame.origin.y=(back.frame.size.height-frame.size.height)/2;
        imgView.image=fromView.image;
    }
    fromView.hidden=YES;
    [UIView animateWithDuration:0.4 animations:^{
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        back.backgroundColor=[UIColor blackColor];
        imgView.frame=frame;
    } completion:^(BOOL finished) {
        complete(back);
        fromView.hidden=NO;
        [imgView setHighlighted:YES];
    }];
}
-(void) goBackToView:(UIImageView*)toView withImage:(UIImage*)image
{
    CGRect rect=[toView.superview convertRect:toView.frame toView:_backView];
    CGRect frame;
    UIImageView * view=(UIImageView * )[_backView viewWithTag:IMAGEVIEW_TAG];
    _backView.hidden=NO;
    toView.hidden=YES;
    if(image!=nil){
         UIImage * bigImage=[image getLimitImage:_backView.frame.size];
         view.image=bigImage;
         view.frame=CGRectMake((_backView.frame.size.width-bigImage.size.width)/2, (_backView.frame.size.height-bigImage.size.height)/2, bigImage.size.width, bigImage.size.height);
    }
    else{
        frame=toView.frame;
        frame.origin.x=(_backView.frame.size.width-frame.size.width)/2;
        frame.origin.y=(_backView.frame.size.height-frame.size.height)/2;
        view.frame=frame;
        view.image=toView.image;
    }
    [UIView animateWithDuration:0.4 animations:^{
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        _backView.backgroundColor=[UIColor clearColor];
        view.frame=rect;
    } completion:^(BOOL finished) {
        toView.hidden=NO;
        [_backView removeFromSuperview];
        _backView=nil;
    }];
}


@end
