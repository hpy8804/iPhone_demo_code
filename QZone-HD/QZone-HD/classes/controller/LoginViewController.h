//
//  LoginViewController.h
//  QZone-HD
//
//  Created by mj on 13-9-9.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
- (IBAction)headClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *head;
@property (weak, nonatomic) IBOutlet UIView *loginView;
- (IBAction)login;
@property (weak, nonatomic) IBOutlet UITextField *qq;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UIButton *rmbPwd;
@property (weak, nonatomic) IBOutlet UIButton *autoLogin;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
- (IBAction)remPwdClick:(UIButton *)sender;
- (IBAction)autoLoginClick:(UIButton *)sender;

@end
