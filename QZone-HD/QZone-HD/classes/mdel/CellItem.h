//
//  CellItem.h
//  QZone-HD
//
//  Created by mj on 13-9-10.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CellItemTypeNone,                   
    CellItemTypeDisclosureIndicator,    
    CellItemTypeDetailDisclosureButton, 
    CellItemTypeCheckmark,
    CellItemTypeSwitch
} CellItemType;

@interface CellItem : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *className;
@property (nonatomic, assign) CellItemType itemType;

+ (id)itemWithText:(NSString *)text itemType:(CellItemType)itemType;
@end