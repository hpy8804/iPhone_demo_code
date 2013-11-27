//
//  HBTalkTableViewTextRightCell.m
//  MyTest
//
//  Created by weqia on 13-8-11.
//  Copyright (c) 2013年 weqia. All rights reserved.
//

#import "HBTalkTableViewTextRightCell.h"

@implementation HBTalkTableViewTextRightCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
#pragma -mark 私有方法

-(void)addText:(NSString*)text
{
    _text=[[HBLabel alloc]initWithFrame:CGRectMake(0, 0, 200, 21)];
    _text.backgroundColor=[UIColor clearColor];
    [_text setFont:[UIFont systemFontOfSize:15]];
    [_text setTextAndIcon:text];
    [_content addSubview:_text];
    CGRect frame=_content.frame;
    frame.size.height=_text.frame.size.height;
    frame.size.width=_text.frame.size.width;
    _content.frame=frame;
    [self layoutSubviews];
}

-(void)upLoadContent
{
    if(self.talkData.dataStatu==HBTalkDataStatuIsUpLoading)
        return;
    self.talkData.dataStatu=HBTalkDataStatuIsUpLoading;
    CGRect rect=_backView.frame;
    indicator=[[HBActivityIndicatorView alloc]init];
    [_cellContent addSubview:indicator];
    indicator.tag=ACTIVITYINDICATOR_TAG;
    indicator.frame=CGRectMake(rect.origin.x-20, (rect.origin.y+(rect.origin.y+rect.size.height-20)/2), 15, 15);
    [indicator startAnimating];
    [self.talkData upLoadData:NULL];
}
-(void)upLoadContent:(UIButton*)button
{
    [button removeFromSuperview];
    [self upLoadContent];
}
-(void)upLoadFailed
{
    if([self.talkData.contents isKindOfClass:[NSString class]]){
        [self addText:self.talkData.contents];
        CGRect rect=_backView.frame;
        UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(rect.origin.x-30,  (rect.origin.y+(rect.origin.y+rect.size.height-20)/2), 25, 25);
        [button setImage:[UIImage imageNamed:@"msg_state_fail_resend.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"msg_state_fail_resend_pressed.png"] forState:UIControlStateHighlighted];
        [_cellContent addSubview:button];
        [button addTarget:self action:@selector(upLoadContent:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma -mark 覆盖父类的方法
-(void)setContent
{
    [super setContent];
    if(self.talkData==nil)
        return;
    [super setContent];
    if(self.talkData.dataStatu==HBTalkDataStatuShouldUpLoad){
        [self addText:self.talkData.contents];
        [self upLoadContent];
        return;
    }else if(self.talkData.dataStatu==HBTalkDataStatuIsUpLoading&&[self.talkData.contents isKindOfClass:[NSString class]]){
        [self addText:self.talkData.contents];
        CGRect rect=_backView.frame;
        indicator=[[HBActivityIndicatorView alloc]init];
        [_cellContent addSubview:indicator];
        indicator.frame=CGRectMake(rect.origin.x-20, (rect.origin.y+(rect.origin.y+rect.size.height-20)/2), 15, 15);
        indicator.tag=ACTIVITYINDICATOR_TAG;
        [indicator startAnimating];
    }else if(self.talkData.dataStatu==HBTalkDataStatuNormal)   {
        [self addText:self.talkData.contents];
        CGRect rect=_backView.frame;
        if(self.talkData.reachStatu==HBTalkDataReachStatuReach){
            UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(rect.origin.x-36,  (rect.origin.y+(rect.origin.y+rect.size.height-20)/2), 35, 15)];
            label.backgroundColor=[UIColor lightGrayColor];
            label.textColor=[UIColor grayColor];
            label.textAlignment=NSTextAlignmentCenter;
            label.layer.cornerRadius=4;
            label.text=@"已送达";
            label.textColor=[UIColor whiteColor];
            label.font=[UIFont systemFontOfSize:11];
            [_cellContent addSubview:label];
        }else if(self.talkData.reachStatu==HBTalkDataReachStatuReaded){
            UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(rect.origin.x-36,  (rect.origin.y+(rect.origin.y+rect.size.height-20)/2), 35, 15)];
            label.backgroundColor=[UIColor lightGrayColor];
            label.textColor=[UIColor grayColor];
            label.layer.cornerRadius=4;
            label.textAlignment=NSTextAlignmentCenter;
            label.text=@"已读";
            label.textColor=[UIColor whiteColor];
            label.font=[UIFont systemFontOfSize:11];
            [_cellContent addSubview:label];
        }
    }else if(self.talkData.dataStatu==HBTalkDataStatuUpLoadFailed){
        [self upLoadFailed];
    
    }
}

@end
