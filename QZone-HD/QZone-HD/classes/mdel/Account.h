//
//  Account.h
//  QZone-HD
//
//  Created by mj on 13-9-9.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject <NSCoding>
@property (nonatomic, copy) NSString *qq;
@property (nonatomic, copy) NSString *pwd;
@property (nonatomic, assign) BOOL rmbPwd;
@property (nonatomic, assign) BOOL autoLogin;
@end
