//
//  HBTalkTableViewImageLeftCell.m
//  MyTest
//
//  Created by weqia on 13-8-11.
//  Copyright (c) 2013年 weqia. All rights reserved.
//

#import "HBTalkTableViewImageLeftCell.h"

@implementation HBTalkTableViewImageLeftCell

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
    [super clear];
    [_image removeFromSuperview];
    _image=nil;
    _smallImage=nil;
    [scroll removeFromSuperview];
    scroll =nil;
    
}

-(void)addImage:(UIImage*)image
{
    _image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    _image.layer.cornerRadius=5;
    _image.clipsToBounds=YES;
    [_content addSubview:_image];
    
    UIImage * limitImage=[image getLimitImage:CGSizeMake(IMAGE_MAX_WIDTH, IMAGE_MAX_HEIGHT)];
    
    CGRect frame=_image.frame;
    frame.size=limitImage.size;
    _image.frame=frame;
    _image.image=limitImage;
    
    frame=_content.frame;
    frame.size=_image.frame.size;
    _content.frame=frame;
    
    _smallImage=image;
    
    UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lookImageAction:)];
    tap.numberOfTapsRequired=1;
    [_backView addGestureRecognizer:tap];
    _backView.userInteractionEnabled=YES;
    
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
    __weak HBTalkTableViewImageLeftCell * wself=self;
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

-(void)setContent
{
    if(self.talkData==nil)
        return;
    [super setContent];
    if(self.talkData.dataStatu==HBTalkDataStatuShouldDownLoad&&[self.talkData.contents isKindOfClass:[NSString class]] ){
        [self downLoadImage:self.talkData.contents];
    }else if(self.talkData.dataStatu==HBTalkDataStatuNormal&&[self.talkData isKindOfClass:[UIImage class]]){
        [self addImage:self.talkData.contents];
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
