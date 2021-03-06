//
//  HBTalkData.h
//  MyTest
//
//  Created by weqia on 13-8-11.
//  Copyright (c) 2013年 weqia. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HBTalkDataStatuChangeNotification  @"HBTalkDataStatuChange"
#define HBTalkDataReachStatuChangeNotification  @"HBTalkDataReachStatuChange"
#define IMAGE_MAX_WIDTH  150
#define IMAGE_MAX_HEIGHT  100

typedef enum {
    HBTalkDataContentTypeText=0,
    HBTalkDataContentTypeImage,
    HBTalkDataContentTypeSound
}HBTalkDataContentType;

typedef enum {
    HBTalkDataStatuNormal=0,
    HBTalkDataStatuShouldDownLoad,
    HBTalkDataStatuIsDownLoading,
    HBTalkDataStatuShouldUpLoad,
    HBTalkDataStatuIsUpLoading,
    HBTalkDataStatuUpLoadFailed
}HBTalkDataStatu;

typedef enum {
    HBTalkDataReachStatuNull=0,
    HBTalkDataReachStatuReach,
    HBTalkDataReachStatuReaded
}HBTalkDataReachStatu;

@interface HBTalkData : NSObject
{
    void(^_upLoadComplete)(BOOL,id,HBTalkData*);
    void(^_downLoadComplete)(BOOL,id,HBTalkData*);
    
    void(^_upLoadProcess)(NSUInteger,long long,HBTalkData*);
    void(^_downLoadProcess)(NSUInteger,long long,HBTalkData*);
    
    HBTalkDataStatu _dataStatu;
    HBTalkDataReachStatu _dataReachStatu;
    
    id _contents;
}
@property(nonatomic,strong) NSString * postTo;
@property(nonatomic,strong) id contents;
@property(nonatomic) NSString * timeInterval;
@property(nonatomic) BOOL fromSelf;
@property(nonatomic) HBTalkDataContentType contentType;
@property(nonatomic) HBTalkDataStatu dataStatu;
@property(nonatomic) HBTalkDataReachStatu reachStatu;

-(void)reset;

-(void) upLoadData:(void(^)(BOOL success ,id backData,HBTalkData*)) complete;

-(void) upLoadData:(void(^)(NSUInteger,long long,HBTalkData*))process complete:(void (^)(BOOL, id,HBTalkData*))complete;

-(void) downLoadData:(void(^)(BOOL success ,id backData,HBTalkData*)) complete;

-(void) downLoadData:(void(^)(NSUInteger,long long,HBTalkData*))process complete:(void(^)(BOOL,id,HBTalkData*))complete;



@end
