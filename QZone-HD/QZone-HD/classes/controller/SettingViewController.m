//
//  SettingViewController.m
//  QZone-HD
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "SettingViewController.h"
#import "CellItem.h"
#import "GroupCell.h"

@interface SettingViewController ()
{
    NSArray *_items;
}
@end

@implementation SettingViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // UI
    [self buildUI];
    
    // 初始化Item
    [self addItems];
}

#pragma mark 搭建UI界面
- (void)buildUI
{
    // 界面属性
    self.title = @"设置";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
    
    // tableview属性
    CGFloat margin = 10;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, margin)];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionFooterHeight = margin;
    
    CGFloat footerHeight = 135;
    // 尾部
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, footerHeight)];
    self.tableView.tableFooterView = footer;
    
    CGFloat footerWidth = 540;
    CGFloat btnX =  14;
    CGFloat btnWidth = footerWidth - 2 * btnX;
    CGFloat btnHeight = 45;
    
    // 退出当前账号
    UIButton *logout = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat logoutY = footerHeight - btnHeight;
    logout.frame = CGRectMake(btnX, logoutY, btnWidth, btnHeight);
    [logout setTitle:@"退出当前帐号" forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizeImage:@"logout_btn_bg.png"] forState:UIControlStateNormal];
    [logout setBackgroundImage:[UIImage resizeImage:@"logout_btn_bg_highlighted.png"] forState:UIControlStateHighlighted];
    [logout addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    logout.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [footer addSubview:logout];
    
    // 清除缓存
    UIButton *clear = [UIButton buttonWithType:UIButtonTypeCustom];
    [clear setTitle:@"清除缓存" forState:UIControlStateNormal];
    CGFloat clearY = logoutY - 5 - btnHeight;
    clear.frame = CGRectMake(btnX, clearY, btnWidth, btnHeight);
    clear.titleLabel.font = logout.titleLabel.font;
    [clear setBackgroundImage:[UIImage resizeImage:@"btn_permission.png"] forState:UIControlStateNormal];
    [clear setBackgroundImage:[UIImage resizeImage:@"btn_permission_click.png"] forState:UIControlStateHighlighted];
    [clear setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [footer addSubview:clear];
}

#pragma mark 退出当前账号
- (void)logout
{
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutNote object:nil];
    }];
}

#pragma mark 初始化item
- (void)addItems
{
    CellItem *note = [CellItem itemWithText:@"通知设置" itemType:CellItemTypeDisclosureIndicator];
    
    CellItem *upload = [CellItem itemWithText:@"上传高清图片" itemType:CellItemTypeSwitch];
    CellItem *waterMark = [CellItem itemWithText:@"照片水印" itemType:CellItemTypeSwitch];
    
    CellItem *power = [CellItem itemWithText:@"权限设置" itemType:CellItemTypeDisclosureIndicator];
    
    CellItem *skin = [CellItem itemWithText:@"皮肤" itemType:CellItemTypeDisclosureIndicator];
    
    CellItem *voice = [CellItem itemWithText:@"提示音" itemType:CellItemTypeSwitch];
    
    CellItem *suggest = [CellItem itemWithText:@"意见反馈" itemType:CellItemTypeDisclosureIndicator];
    CellItem *about = [CellItem itemWithText:@"关于" itemType:CellItemTypeDisclosureIndicator];
    
    _items = @[
               @[note],
               @[upload, waterMark],
               @[power],
               @[skin],
               @[voice],
               @[suggest, about]];
}

- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = _items[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    GroupCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[GroupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.myTableView = tableView;
    }
    
    cell.indexPath = indexPath;
    cell.cellItem = _items[indexPath.section][indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end