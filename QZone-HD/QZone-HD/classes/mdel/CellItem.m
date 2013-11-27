//
//  CellItem.m
//  QZone-HD
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "CellItem.h"

@implementation CellItem
+ (id)itemWithText:(NSString *)text itemType:(CellItemType)itemType
{
    CellItem *item = [[CellItem alloc] init];
    item.text = text;
    item.itemType = itemType;
    return item;
}
@end
