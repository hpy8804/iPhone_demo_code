//
//  HBTalkTableViewCell.h
//  MyTest
//
//  Created by weqia on 13-8-10.
//  Copyright (c) 2013年 weqia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "HBLabel.h"
#import "HBAnimationUtil.h"
#import "UIImageView+HBHttpCache.h"
#import "HBImageScroller.h"
#import "HBTalkData.h"
#import "HBActivityIndicatorView.h"
#import "TimeUtil.h"


#define ACTIVITYINDICATOR_TAG 1000

@interface HBTalkTableViewCell : UITableViewCell
{
    UIView * _time;
    UIView * _cellContent;
    
    UIImageView * _mLogo;
    UIImageView * _backView;
    UIView *_content;
}
@property(nonatomic,strong) HBTalkData * talkData;
@property(nonatomic,strong) HBTalkData * preTalkData;

-(void)clear;

-(void)setContent;

+(float)getHeightByContent:(HBTalkData*)data preData:(HBTalkData*)preData;

-(void) setLogoImage:(NSString*)url;

-(void)setLogoImageWithImage:(UIImage*)image;

@end
