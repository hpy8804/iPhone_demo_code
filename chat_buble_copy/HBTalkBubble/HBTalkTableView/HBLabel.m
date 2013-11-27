//
//  HBLabel.m
//  MyTest
//
//  Created by weqia on 13-7-14.
//  Copyright (c) 2013年 weqia. All rights reserved.
//

#import "HBLabel.h"

@implementation HBLabel
#pragma -mark 私有方法
+(NSDictionary*)getFaceMap
{
    static NSDictionary * dic=nil;
    if(dic==nil){
        NSString* path=[[NSBundle mainBundle] pathForResource:@"faceMap_ch" ofType:@"plist"];
        dic =[NSDictionary dictionaryWithContentsOfFile:path];
    }
    return dic;
}
+(NSString*)faceKeyForValue:(NSString*)value  map:(NSDictionary*) map
{
    NSArray * keys=[map allKeys];
    int count=[keys count];
    for(int i=0;i<count;i++)
    {
            NSString * key=[keys objectAtIndex:i];
            if([[map objectForKey:key] isEqualToString:value])
                return key;
    }
    return nil;
}

-(int)getRightIndex:(NSString*)resource forWidth:(float)width
{
    int length=[resource length];
    for(int i=1;i<length;i++)
    {
        NSString * subStr=[resource substringToIndex:i];
        CGSize size=[subStr sizeWithFont:self.font];
        if(size.width>width)
            return i-1;
    }
    return length-1;
}

-(void)drawText:(NSString*)string
{
    if(xIndex+SPACE_WIDTH+5>maxWidth)
    {
        xIndex=0.0f;
        yIndex+=LINE_HEIGHT;
    }
    CGSize size=[string sizeWithFont:self.font];
    while (size.width>(maxWidth-xIndex))
    {
        int index=[self getRightIndex:string forWidth:maxWidth-xIndex];
        NSString * sub=[string substringToIndex:index];
        CGSize subSize=[sub sizeWithFont:self.font];
        UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(xIndex, yIndex,subSize.width , subSize.height)];
        label.text=sub;
        label.textColor=self.textColor;
        label.font=self.font;
        label.backgroundColor=[UIColor clearColor];
        [self addSubview:label];
        xIndex=0;
        line++;
        yIndex+=LINE_HEIGHT;
        string=[string substringFromIndex:index];
        size=[string sizeWithFont:self.font];
    }
    UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(xIndex, yIndex,size.width , size.height)];
    label.text=string;
    label.textColor=self.textColor;
    label.font=self.font;
    label.backgroundColor=[UIColor clearColor];
    [self addSubview:label];
    xIndex+=size.width;
}

-(void)drawIcon:(NSString*)string
{
    NSString * icon=[HBLabel faceKeyForValue:string map:[HBLabel getFaceMap]];
    if(icon==nil)
    {
        [self drawText:string];
        return;
    }
    NSMutableString * iconFile=[NSMutableString stringWithString:icon];
    [iconFile appendFormat:@".png"];
    UIImageView * image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:iconFile]];
    if(xIndex+ICON_SIZE+SPACE_WIDTH>=maxWidth)
    {
        xIndex=0.0f;
        yIndex+=LINE_HEIGHT;
        line++;
    }
    image.frame=CGRectMake(SPACE_WIDTH+xIndex,(LINE_HEIGHT-ICON_SIZE)/2+yIndex, ICON_SIZE, ICON_SIZE);
    [self addSubview:image];
    xIndex=xIndex+ICON_SIZE+SPACE_WIDTH;
}


#pragma -mrak 接口方法
-(void) setTextAndIcon:(NSString*)string
{
    IconMatch * match=[[IconMatch alloc]init];
    NSArray * strs=[match Match:string];
    line=1;
    xIndex=0.0f;
    yIndex=0.0f;
     maxWidth=self.frame.size.width;
    int count=[strs count];
    for(int i=0;i<count;i++){
        NSString * string=[strs objectAtIndex:i];
        if([string hasPrefix:BEGIN_TAG]&&[string hasSuffix:END_TAG])
        {
            [self drawIcon:string];
        }else
        {
            [self drawText:string];
       }
    }
    CGRect frame=self.frame;
    frame.size.height=yIndex+21;
    if(line==1)
        frame.size.width=xIndex;
    self.frame=frame;
}

@end


@implementation NSString (HBLabel)

-(CGSize) hbSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    IconMatch * match=[[IconMatch alloc]init];
    NSArray * strs=[match Match:self];
    float xIndex=0.0f;
    float yIndex=0.0f;
    float maxWidth=size.width;
    int count=[strs count];
    for(int i=0;i<count;i++){
        NSString * string=[strs objectAtIndex:i];
        if([string hasPrefix:BEGIN_TAG]&&[string hasSuffix:END_TAG]){
            NSString * icon=[HBLabel faceKeyForValue:string map:[HBLabel getFaceMap]];
            if(icon==nil)
            {
                if(xIndex+SPACE_WIDTH+5>maxWidth)
                {
                    xIndex=0.0f;
                    yIndex+=LINE_HEIGHT;
                }
                CGSize size=[string sizeWithFont:font];
                while (size.width>(maxWidth-xIndex))
                {
                    int index=[self getRightIndex:string forWidth:maxWidth-xIndex withFont:font];
                    xIndex=0;
                    yIndex+=LINE_HEIGHT;
                    string=[string substringFromIndex:index];
                    size=[string sizeWithFont:font];
                }
                xIndex+=size.width;
            }
            if(xIndex+ICON_SIZE+SPACE_WIDTH>=maxWidth)
            {
                xIndex=0.0f;
                yIndex+=LINE_HEIGHT;
            }
            xIndex=xIndex+ICON_SIZE+SPACE_WIDTH;
        }else{
            if(xIndex+SPACE_WIDTH+5>maxWidth)
            {
                xIndex=0.0f;
                yIndex+=LINE_HEIGHT;
            }
            CGSize size=[string sizeWithFont:font];
            while (size.width>(maxWidth-xIndex))
            {
                int index=[self getRightIndex:string forWidth:maxWidth-xIndex withFont:font];
                xIndex=0;
                yIndex+=LINE_HEIGHT;
                string=[string substringFromIndex:index];
                size=[string sizeWithFont:font];
            }
            xIndex+=size.width;
        }
    }
    return CGSizeMake(xIndex, yIndex+LINE_HEIGHT);
}

-(int)getRightIndex:(NSString*)resource forWidth:(float)width withFont:(UIFont*)font
{
    int length=[resource length];
    for(int i=1;i<length;i++)
    {
        NSString * subStr=[resource substringToIndex:i];
        CGSize size=[subStr sizeWithFont:font];
        if(size.width>width)
            return i-1;
    }
    return length-1;
}

@end
