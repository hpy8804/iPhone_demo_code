//
//  ViewController.m
//  汉字转拼音
//
//  Created by Administrator on 12-10-30.
//  Copyright (c) 2012年 刘鹏卫. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@",[ChineseToPinyin pinyinFromChiniseString:@"中国人很伟大"]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
