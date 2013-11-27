//
//  Account.m
//  QZone-HD
//
//  Created by mj on 13-9-9.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "Account.h"

#define kQQ @"qq"
#define kPwd @"pwd"
#define kAutoLogin @"auto_login"
#define kRmbPwd @"rmb_pwd"

@implementation Account
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.qq = [decoder decodeObjectForKey:kQQ];
        self.pwd = [decoder decodeObjectForKey:kPwd];
        self.autoLogin = [decoder decodeBoolForKey:kAutoLogin];
        self.rmbPwd = [decoder decodeBoolForKey:kRmbPwd];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.qq forKey:kQQ];
    [encoder encodeObject:self.pwd forKey:kPwd];
    [encoder encodeBool:self.autoLogin forKey:kAutoLogin];
    [encoder encodeBool:self.rmbPwd forKey:kRmbPwd];
}

- (BOOL)isEqual:(Account *)object
{
    return [_qq isEqualToString:object.qq];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"[QQ=%@, PWD=%@]", _qq, _pwd];
}
@end
