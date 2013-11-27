//
//  AccountTool.m
//  SinaWeibo
//
//  Created by mj on 13-8-20.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "AccountTool.h"
#import "Account.h"

#define kFileName @"accounts.data"

#define kAllAccounts @"all_accounts"
#define kCurrentAccount @"current_account"

#define kAccountMax 4

#define kPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:kFileName]

@interface AccountTool()
{
    NSMutableDictionary *_allData;
    NSMutableArray *_allAccounts;
}
@end

@implementation AccountTool
singleton_implementation(AccountTool)

- (id)init
{
    if (self = [super init]) {
        // 1.从文件读取数据
        _allData = [NSKeyedUnarchiver unarchiveObjectWithFile:kPath];
        
        // 2.说明没有游戏数据
        if (!_allData) {
            _allData = [NSMutableDictionary dictionary];
            _allAccounts = [NSMutableArray array];
            [_allData setObject:_allAccounts forKey:kAllAccounts];
        } else {
            _allAccounts = _allData[kAllAccounts];
            _currentAccount = _allData[kCurrentAccount];
        }
    }
    return self;
}

#pragma mark 添加新的账号
- (void)saveAccount:(Account *)account
{
    // 1.判断添加还是更新
    int index = [_allAccounts indexOfObject:account];
    if (index != NSNotFound) {
        // 将账号插入到最前面
        [_allAccounts removeObjectAtIndex:index];
        [_allAccounts insertObject:account atIndex:0];
    } else {
        // 添加账号
        [_allAccounts insertObject:account atIndex:0];
        
        // 删除最后一个
        if (_allAccounts.count > kAccountMax) {
            [_allAccounts removeLastObject];
        }
    }
    
    // 2.设置为当前账号
    _currentAccount = account;
    [_allData setObject:_currentAccount forKey:kCurrentAccount];
    
    NSLog(@"\n所有账号：\n%@", _allAccounts);
    
    // 3.归档
    [NSKeyedArchiver archiveRootObject:_allData toFile:kPath];
}
@end