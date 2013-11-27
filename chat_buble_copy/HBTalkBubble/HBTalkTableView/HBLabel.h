//
//  HBLabel.h
//  MyTest
//
//  Created by weqia on 13-7-14.
//  Copyright (c) 2013年 weqia. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "IconMatch.h"

#define ICON_SIZE 20.0f
#define LINE_HEIGHT 20.0f
#define SPACE_WIDTH 2.0f

@interface HBLabel:UILabel
{
    int line;
    float xIndex,yIndex;
    float maxWidth;
}
-(void) setTextAndIcon:(NSString*)string;

@end



@interface NSString (HBLabel)

-(CGSize) hbSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

@end