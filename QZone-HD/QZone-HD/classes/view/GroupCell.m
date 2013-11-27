//
//  GroupCell.m
//  QZone-HD
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "GroupCell.h"
#import "CellItem.h"

@interface GroupCell()
{
    UISwitch *_swtich;
    // 背景view
    UIImageView *_bgView;
    UIImageView *_selectedBgView;
}
@end

@implementation GroupCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1.设置背景view
        _bgView = [[UIImageView alloc] init];
        self.backgroundView = _bgView;
        _selectedBgView =[[UIImageView alloc] init];
        self.selectedBackgroundView = _selectedBgView;
        
        // 2.设置标签背景颜色
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.highlightedTextColor = self.textLabel.textColor;
    }
    return self;
}

- (void)setCellItem:(CellItem *)cellItem
{
    _cellItem = cellItem;
    
    self.textLabel.text = cellItem.text;
    if (cellItem.itemType == CellItemTypeSwitch) {
        if (_swtich == nil) {
            _swtich = [[UISwitch alloc] init];
        }
        self.accessoryView = _swtich;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        self.accessoryView = nil;
        self.accessoryType = cellItem.itemType;
    }
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    
    // 1.算出文件名
    NSString *centerName = nil;
    int rowsCount = [_myTableView numberOfRowsInSection:indexPath.section];
    if (rowsCount == 1) {
        centerName = @"";
    } else if (indexPath.row == 0) { // 顶部
        centerName = @"_top";
    } else if (indexPath.row == rowsCount - 1) { // 底部
        centerName = @"_bottom";
    } else { // 中间
        centerName = @"_middle";
    }
    
    // 2.设置图片
    _bgView.image = [UIImage resizeImage:[NSString stringWithFormat:@"common_card%@_background.png", centerName]];
    _selectedBgView.image = [UIImage resizeImage:[NSString stringWithFormat:@"common_card%@_background_highlighted.png", centerName]];
}

- (void)setFrame:(CGRect)frame
{
    CGFloat padding = 15;
    frame.origin.x = -padding;
    frame.size.width += 2 * padding;
    [super setFrame:frame];
}
@end