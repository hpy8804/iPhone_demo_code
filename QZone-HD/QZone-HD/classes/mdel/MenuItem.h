//
//  MenuItem.h
//  QZone-HD
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuItem : NSObject
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *className;
@property (nonatomic, assign) BOOL modal;
+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title className:(NSString *)className;
+ (id)itemWithIcon:(NSString *)icon title:(NSString *)title className:(NSString *)className modal:(BOOL)modal;
+ (id)itemWithIcon:(NSString *)icon;
@end