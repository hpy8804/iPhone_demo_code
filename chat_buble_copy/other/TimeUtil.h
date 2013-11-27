//
//  TimeUtil.h
//  wq
//
//  Created by berwin on 13-7-20.
//  Copyright (c) 2013年 Weqia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeUtil : NSObject

+ (NSString*)getTimeStr:(long) createdAt;

+ (NSString*)getFullTimeStr:(long long)time;

+ (NSString*)getMDStr:(long long)time;

+(NSDateComponents*) getComponent:(long long)time;

+(NSString*) getTimeStrStyle1:(long long)time;

+(NSString*) getTimeStrStyle2:(long long)time;

@end
