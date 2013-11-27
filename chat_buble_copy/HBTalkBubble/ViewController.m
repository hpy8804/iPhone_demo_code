//
//  ViewController.m
//  HBTalkBubble
//
//  Created by weqia on 13-8-23.
//  Copyright (c) 2013年 hb. All rights reserved.
//

#import "ViewController.h"
#import "HBHttpRequestCache.h"
@interface ViewController ()

@end

@implementation ViewController
-(void)clearCachesAction{
    [HBHttpRequestCache clearCache];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [clearcache addTarget:self action:@selector(clearCachesAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
