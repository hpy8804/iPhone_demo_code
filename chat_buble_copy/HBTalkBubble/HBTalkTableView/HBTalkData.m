//
//  HBTalkData.m
//  MyTest
//
//  Created by weqia on 13-8-11.
//  Copyright (c) 2013年 weqia. All rights reserved.
//

#import "HBTalkData.h"

@implementation HBTalkData
@synthesize fromSelf,contents=_contents,timeInterval,contentType,dataStatu=_dataStatu,reachStatu=_dataReachStatu,postTo;

-(void) downLoadData:(void(^)(BOOL success ,id backData,HBTalkData*)) complete
{
    [self downLoadData:nil complete:complete];
}

-(void) downLoadData:(void(^)(NSUInteger,long long,HBTalkData*))process complete:(void(^)(BOOL,id,HBTalkData*))complete
{
    _downLoadComplete=complete;
    _downLoadProcess=process;
    
}


#pragma -mark 上传内容
-(void) upLoadData:(void(^)(BOOL success ,id backData,HBTalkData*)) complete
{
    [self upLoadData:nil complete:complete];
}
-(void) upLoadData:(void(^)(NSUInteger,long long,HBTalkData*))process complete:(void (^)(BOOL, id,HBTalkData*))complete
{
    _upLoadComplete=complete;
    _upLoadProcess=process;
    [self performSelector:@selector(uploadFinish) withObject:nil afterDelay:43];
}
#pragma -mrak setting 方法
-(void)setDataStatu:(HBTalkDataStatu)dataStatu1
{
    _dataStatu=dataStatu1;
    [[NSNotificationCenter defaultCenter] postNotificationName:HBTalkDataStatuChangeNotification object:self];
}
-(void)setReachStatu:(HBTalkDataReachStatu)reachStatu1
{
    _dataReachStatu=reachStatu1;
    [[NSNotificationCenter defaultCenter] postNotificationName:HBTalkDataReachStatuChangeNotification object:self];
}

#pragma -mark  接口方法
-(void)reset
{
    _dataReachStatu=HBTalkDataReachStatuNull;
    _dataStatu=HBTalkDataStatuNormal;
    self.contents=nil;
    self.timeInterval=nil;
    self.contentType=HBTalkDataContentTypeText;
}
#pragma -mark 事件响应方法
-(void) uploadFinish
{
    if(_upLoadComplete){
        _upLoadComplete(YES,nil,self);
    }
    self.dataStatu=HBTalkDataStatuNormal;
}

-(void) downloadFinish
{

}
@end
