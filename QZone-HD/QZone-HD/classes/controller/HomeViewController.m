//
//  HomeViewController.m
//  QZone-HD
//
//  Created by mj on 13-9-9.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "HomeViewController.h"
#import "Dock.h"
#import "MenuItem.h"

@interface HomeViewController ()
{
    Dock *_dock;
    NSMutableDictionary *_childs;
    
    UINavigationController *_currentChild;
}
@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kGlobalBg;
    
    // 1.子控制器的容器
    _childs = [NSMutableDictionary dictionary];
    
    // 2.添加左边的view
    _dock = [[Dock alloc] init];
    // 根据屏幕方向设置属性
    [_dock rotateToOrientation:self.interfaceOrientation];
    __unsafe_unretained HomeViewController *home = self;
    _dock.dockClick = ^(MenuItem *item) {
        // 切换控制器
        [home selectChildWithItem:item];
    };
    _dock.iconClick = ^{
        [home selectChildWithItem:[MenuItem itemWithIcon:nil title:nil className:@"ProfileViewController"]];
    };
    [self.view addSubview:_dock];
    
    // 3.默认点击了头像
    _dock.iconClick();
    
    // 4.通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout) name:kLogoutNote object:nil];
}

#pragma mark 退出登录
- (void)logout
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)selectChildWithItem:(MenuItem *)item
{
    // 1.取出之前的控制器
    UINavigationController *nav = _childs[item.className];
    if (nav == nil) {
        Class c = NSClassFromString(item.className);
        UIViewController *vc = [[c alloc] init];
        vc.view.backgroundColor = kViewBg;
        
        nav = [[UINavigationController alloc] initWithRootViewController:vc];
        if (item.modal) {
            nav.modalPresentationStyle = UIModalPresentationFormSheet;
            [self presentViewController:nav animated:YES completion:nil];
            return;
        }
        
        nav.view.autoresizingMask = UIViewAutoresizingNone;
        [nav.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragView:)]];
        [self addChildViewController:nav];
        
        [_childs setObject:nav forKey:item.className];
    }
    
    // 2.如果一样，就返回
    if (nav == _currentChild) return;
    
    // 3.移除旧的
    [_currentChild.view removeFromSuperview];
    
    // 4.添加新的
    CGFloat x = CGRectGetMaxX(_dock.frame);
    CGFloat width = 768 - kDockComposeBtnWidthP;
    CGFloat height = _dock.frame.size.height;
    nav.view.frame = CGRectMake(x, 0, width, height);
    [self.view addSubview:nav.view];
    _currentChild = nav;
}

#pragma mark 拖拽
- (void)dragView:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
        [UIView animateWithDuration:0.3 animations:^{
            pan.view.transform = CGAffineTransformIdentity;
        }];
    } else {
        CGFloat tx = [pan translationInView:pan.view].x;
        pan.view.transform = CGAffineTransformMakeTranslation(tx * 0.5, 0);
    }
}

#pragma mark 屏幕即将旋转
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^{
        [_dock rotateToOrientation:toInterfaceOrientation];
        
        CGRect frame = _currentChild.view.frame;
        frame.origin.x = CGRectGetMaxX(_dock.frame);
        frame.size.height = _dock.frame.size.height;
        _currentChild.view.frame = frame;
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLogoutNote object:nil];
}
@end
