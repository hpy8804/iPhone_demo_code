//
//  LoginViewController.m
//  QZone-HD
//
//  Created by mj on 13-9-9.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Account.h"
#import "AccountTool.h"

@interface LoginViewController ()

@end

@implementation LoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = kGlobalBg;
}

- (void)alertError:(NSString *)message
{
    // 1.弹框
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    
    // 2.执行动画
    CAKeyframeAnimation *translate = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    translate.repeatCount = 1;
    CGFloat delta = 20;
    translate.values = @[@(-delta), @(delta), @(-delta)];
    [_loginView.layer addAnimation:translate forKey:nil];
}

- (IBAction)login {
    // 1.如果没有账号
    if (_qq.text.length == 0) {
        [self alertError:@"请输入账号"];
        return;
    }
    
    // 2.如果没有密码
    if (_pwd.text.length == 0) {
        [self alertError:@"请输入密码"];
        return;
    }
    
    // 3.开始动画
    self.view.userInteractionEnabled = NO;
    [_activity startAnimating];
    
    [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(loginSuccess) userInfo:nil repeats:NO];
}

- (void)loginSuccess
{
    // 1.停止动画
    [_activity stopAnimating];
    
    // 2.保存账号
    Account *account = [[Account alloc] init];
    account.qq = _qq.text;
    account.pwd = _pwd.text;
    account.rmbPwd = _rmbPwd.isSelected;
    account.autoLogin = _autoLogin.isSelected;
    [[AccountTool sharedAccountTool] saveAccount:account];
    
    // 3.跳到主页
    self.view.userInteractionEnabled = YES;
    [self performSegueWithIdentifier:@"home" sender:nil];
}

- (IBAction)remPwdClick:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    
    // 取消选中自动登录
    if (!sender.isSelected) {
        _autoLogin.selected = NO;
    }
}

- (IBAction)autoLoginClick:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    
    // 选中记住密码
    if (sender.isSelected) {
        _rmbPwd.selected = YES;
    }
}
- (IBAction)headClick:(UIButton *)sender {
    
}
@end
