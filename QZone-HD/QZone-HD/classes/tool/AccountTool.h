//
//  AccountTool.h
//  SinaWeibo
//
//  Created by mj on 13-8-20.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "Account.h"

@interface AccountTool : NSObject
singleton_interface(AccountTool)

- (void)saveAccount:(Account *)account;

@property (nonatomic, strong, readonly) Account *currentAccount;
@end
