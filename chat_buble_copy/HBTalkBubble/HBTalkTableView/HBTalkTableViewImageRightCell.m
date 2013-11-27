//
//  HBTalkTableViewImageRightCell.m
//  MyTest
//
//  Created by weqia on 13-8-11.
//  Copyright (c) 2013年 weqia. All rights reserved.
//

#import "HBTalkTableViewImageRightCell.h"

@implementation HBTalkTableViewImageRightCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
#pragma -mark 私有方法
-(void)clear
{
    [_image removeFromSuperview];
    _image=nil;
    _smallImage=nil;
    [scroll removeFromSuperview];
    scroll =nil;
    [super clear];
    
}
-(void)addImage:(UIImage*)image1
{
    _image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    _image.layer.cornerRadius=5;
    _image.clipsToBounds=YES;
    [_content addSubview:_image];
    
    UIImage * limitImage=[image1 getLimitImage:CGSizeMake(IMAGE_MAX_WIDTH, IMAGE_MAX_HEIGHT)];
    
    CGRect frame=_image.frame;
    frame.size=limitImage.size;
    _image.frame=frame;
    _image.image=limitImage;
    
    frame=_content.frame;
    frame.size=_image.frame.size;
    _content.frame=frame;
    
    _smallImage=limitImage;
    
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookImageAction:)];
    tap.numberOfTapsRequired=1;
    [_backView addGestureRecognizer:tap];
    _backView.userInteractionEnabled=YES;
    
    [self layoutSubviews];
}

-(void)downLoadImage:(NSString*)url
{
    _image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,150,100)];
    CGRect frame=_content.frame;
    frame.size=CGSizeMake(50, 50);
    _content.frame=frame;
    
    _image.layer.cornerRadius=5;
    _image.clipsToBounds=YES;
    
    __weak UIImageView * wimage=_image;
    __weak UIView * wcontent=_content;
    __weak HBTalkTableViewImageRightCell * wself=self;
    [_image setImageWithURL:url layout:UIImageViewLayoutLimit placeholderImage:nil process:nil  complete:^(UIImage * image, NSData * data, NSError * error, BOOL success) {
        if(!wimage||!wcontent||!wself)return;
        CGRect frame=wcontent.frame;
        frame.size=wimage.frame.size;
        wcontent.frame=frame;
        [wself layoutSubviews];
        
        [wcontent addSubview:wimage];
        
        UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:wself action:@selector(lookImageAction:)];
        [wimage addGestureRecognizer:tap];
        wimage.userInteractionEnabled=YES;
    }];
}
-(void)upLoadImage
{
    self.talkData.dataStatu=HBTalkDataStatuIsUpLoading;
    CGRect rect=_backView.frame;
    indicator=[[HBActivityIndicatorView alloc]init];
    [_cellContent addSubview:indicator];
    indicator.tag=ACTIVITYINDICATOR_TAG;
    indicator.frame=CGRectMake(rect.origin.x-20, (rect.origin.y+(rect.origin.y+rect.size.height-30)/2), 15, 15);
    [_cellContent addSubview:indicator];
    [indicator startAnimating];
    [self.talkData upLoadData:NULL];
}
-(void)upLoadContent:(UIButton*)button
{
    [button removeFromSuperview];
    [self upLoadImage];
}

-(void)upLoadFailed
{
    if([self.talkData.contents isKindOfClass:[UIImage class]]){
        [self addImage:self.talkData.contents];
        CGRect rect=_backView.frame;
        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(rect.origin.x-30,  (rect.origin.y+(rect.origin.y+rect.size.height-30)/2), 25, 25);
        [button setImage:[UIImage imageNamed:@"msg_state_fail_resend.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"msg_state_fail_resend_pressed.png"] forState:UIControlStateHighlighted];
        [_cellContent addSubview:button];
        [button addTarget:self action:@selector(upLoadContent:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,100, 15)];
        label.backgroundColor=[UIColor clearColor];
        label.textColor=[UIColor lightGrayColor];
        label.textAlignment=NSTextAlignmentCenter;
        label.text=@"发送图片失败";
        label.font=[UIFont systemFontOfSize:14];
        [_content addSubview:label];
        CGRect frame=_content.frame;
        frame.size=CGSizeMake(100, 15);
        _content.frame=frame;
        [self layoutSubviews];
    }
}

-(void)setReched
{
    CGRect rect=_backView.frame;
    if(self.talkData.reachStatu==HBTalkDataReachStatuReach){
        UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(rect.origin.x-36,  (rect.origin.y+(rect.origin.y+rect.size.height-30)/2), 35, 15)];
        label.backgroundColor=[UIColor lightGrayColor];
        label.textColor=[UIColor grayColor];
        label.textAlignment=NSTextAlignmentCenter;
        label.layer.cornerRadius=4;
        label.text=@"已送达";
        label.font=[UIFont systemFontOfSize:11];
        label.textColor=[UIColor whiteColor];
        [_cellContent addSubview:label];
    }else if(self.talkData.reachStatu==HBTalkDataReachStatuReaded){
        UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(rect.origin.x-36,  (rect.origin.y+(rect.origin.y+rect.size.height-30)/2), 35, 15)];
        label.backgroundColor=[UIColor lightGrayColor];
        label.textColor=[UIColor grayColor];
        label.layer.cornerRadius=4;
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=[UIColor whiteColor];
        label.text=@"已读";
        label.font=[UIFont systemFontOfSize:11];
        [_cellContent addSubview:label];
    }
}

-(void)setContent
{
    if(self.talkData==nil)
        return;
    [super setContent];
    if(self.talkData.dataStatu==HBTalkDataStatuShouldDownLoad&&[self.talkData.contents isKindOfClass:[NSString class]] ){
        [self downLoadImage:self.talkData.contents];
    }else if(self.talkData.dataStatu==HBTalkDataStatuNormal&&[self.talkData.contents isKindOfClass:[UIImage class]]){
        [self addImage:self.talkData.contents];
        [self setReched];
    }else if(self.talkData.dataStatu==HBTalkDataStatuShouldUpLoad&&[self.talkData.contents isKindOfClass:[UIImage class] ]){
        [self addImage:self.talkData.contents];
        [self upLoadImage];
    }else if(self.talkData.dataStatu==HBTalkDataStatuIsUpLoading&&[self.talkData.contents isKindOfClass:[UIImage class]]){
        [self addImage:self.talkData.contents];
        indicator=[[HBActivityIndicatorView alloc]init];
        [_cellContent addSubview:indicator];
        CGRect rect=_backView.frame;
        indicator.frame=CGRectMake(rect.origin.x-20, (rect.origin.y+(rect.origin.y+rect.size.height-30)/2), 15, 15);
        [indicator startAnimating];
    }else if(self.talkData.dataStatu==HBTalkDataStatuUpLoadFailed)
    {
        [self upLoadFailed];
    }
    [self layoutSubviews];
}

#pragma -mark 事件响应方法
-(void)lookImageAction:(UIGestureRecognizer*)sender
{
    if(_image==nil)
        return;
    UIImage * image=nil;
    scroll=[[HBImageScroller alloc]initWithFrame:[UIScreen mainScreen].bounds];
    scroll.backgroundColor=[UIColor blackColor];
    if(self.talkData.dataStatu==HBTalkDataStatuShouldDownLoad){
        [scroll setImageWithURL:self.talkData.contents andSmallImage:_smallImage];
    }else if([self.talkData.contents isKindOfClass:[UIImage class]]){
        [scroll setImage:self.talkData.contents];
        image=self.talkData.contents;
    }else{
        return;
    }
    [scroll addTarget:self tapOnceAction:@selector(unLookImageAction)];
    [[HBAnimationUtil shareAnimation] showBigImage:image fromView:_image complete:^(UIView *bacView) {
        [bacView setHidden:YES];
        [self.window addSubview:scroll];
    }];
    
}

-(void)unLookImageAction
{
    [scroll removeFromSuperview];
    scroll=nil;
    UIImage * image=nil;
    if([self.talkData.contents isKindOfClass:[UIImage class]])
        [scroll setImage:self.talkData.contents];
    [[HBAnimationUtil shareAnimation] goBackToView:_image withImage:image];
}



@end
