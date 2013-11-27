//
//  AllStatusViewController.m
//  QZone-HD
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "AllStatusViewController.h"
#import "SegmentView.h"

@interface AllStatusViewController ()

@end

@implementation AllStatusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SegmentView *segment = [[SegmentView alloc] init];
    segment.titles = @[@"全部", @"特别关心", @"好友动态", @"认证空间"];
    self.navigationItem.titleView = segment;
}

@end
