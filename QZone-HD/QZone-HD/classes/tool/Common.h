
/*
 编辑按钮
 */
// 横屏宽度
#define kDockComposeBtnWidthL 90
// 横屏高度
#define kDockComposeBtnHeightL 90
// 竖屏宽度
#define kDockComposeBtnWidthP 65
// 竖屏高度
#define kDockComposeBtnHeightP 65

#define kGroupTableBorderWidth 5

/*
 菜单按钮
 */
// 高度
#define KDockMenuBtnHeight kDockComposeBtnHeightP

/*
 通知
 */
#define kLogoutNote @"logout_note"

// 获得颜色
#define kGetColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define kGlobalBg kGetColor(46, 46, 46)
#define kViewBg kGetColor(221, 221, 221)

// 获得当前屏幕的高度
#define kScreenHeight(orientation) (UIInterfaceOrientationIsLandscape(orientation)?([UIScreen mainScreen].bounds.size.width-20):([UIScreen mainScreen].bounds.size.height-20))

// 获得当前屏幕的宽度
#define kScreenWidth(orientation) (UIInterfaceOrientationIsLandscape(orientation)?[UIScreen mainScreen].bounds.size.height:[UIScreen mainScreen].bounds.size.width)