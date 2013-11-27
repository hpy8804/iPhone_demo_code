//
//  HBImageScroller.m
//  MyTest
//
//  Created by weqia on 13-7-31.
//  Copyright (c) 2013年 weqia. All rights reserved.
//

#import "HBImageScroller.h"

@implementation HBImageScroller
@synthesize imageView=_imageView;

#pragma -mark 覆盖父类的方法


#pragma -mark 事件响应方法

-(void)imagePinchAction:(UIPinchGestureRecognizer*)recognizer
{
    if(recognizer.state==UIGestureRecognizerStateBegan)
    {
        _beginSize=_imageView.frame.size;
        
    }
    else if(recognizer.state==UIGestureRecognizerStateChanged)
    {
        int width= _beginSize.width*recognizer.scale;
        int height=(_imageView.frame.size.height/_imageView.frame.size.width*width);
        if(width<2*self.frame.size.width&&width>0.5*self.frame.size.width)
        {
            self.contentSize=CGSizeMake(width,height);
            float y=[self getFrameForImageView].origin.y-(height-[self getFrameForImageView].size.height)/3>0?[self getFrameForImageView].origin.y-(height-[self getFrameForImageView].size.height)/3:0;
            if(y>[self getFrameForImageView].origin.y)
                y=[self getFrameForImageView].origin.y;
            if(width>self.frame.size.width&&height>self.frame.size.height)
                _imageView.frame=CGRectMake(0,0 , width, height);
            else if(width<self.frame.size.width&&height>self.frame.size.height)

                _imageView.frame=CGRectMake((self.frame.size.width-width)/2,0, width, height);
            else if(width>self.frame.size.width&&height<self.frame.size.height)
                _imageView.frame=CGRectMake(0,(self.frame.size.height-height)/2, width, height);
            else
                _imageView.frame=CGRectMake((self.frame.size.width-width)/2,(self.frame.size.height-height)/2, width, height);

        }
       
    }
    else if(recognizer.state==UIGestureRecognizerStateEnded)
    {
        if(self.contentSize.width<self.frame.size.width)
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.2];
            _imageView.frame=[self getFrameForImageView];
            self.contentSize=self.frame.size;
            [UIView commitAnimations];
            max=NO;
        }
        else if(self.contentSize.width>1.5*self.frame.size.width)
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.2];
            CGSize size=self.contentSize;
            size.width=self.frame.size.width*1.5;
            size.height=(_imageView.frame.size.height/_imageView.frame.size.width*size.width);
            self.contentSize=size;
            if(size.height>self.frame.size.height)
                _imageView.frame= CGRectMake(0, 0, size.width, size.height);
            else
               _imageView.frame=CGRectMake(0,(self.frame.size.height-size.height)/2, size.width, size.height);
            [UIView commitAnimations];
            max=YES;
        }

    }
}

-(void)imageTapTwoAction:(UIGestureRecognizer*)recognizer
{
        if(max)
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.2];
            _imageView.frame=[self getFrameForImageView];
            self.contentSize=self.frame.size;
            [UIView commitAnimations];
            max=NO;
        }
        else
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.2];
            CGSize size=self.contentSize;
            size.width=self.frame.size.width*1.5;
            size.height=(_imageView.frame.size.height/_imageView.frame.size.width*size.width);
            self.contentSize=size;
            if(size.height>self.frame.size.height)
                _imageView.frame= CGRectMake(0, 0, size.width, size.height);
            else
                _imageView.frame=CGRectMake(0,(self.frame.size.height-size.height)/2, size.width, size.height);
            LocationRegion region=[self getLocationRegion:[recognizer locationInView:self]];
            switch (region) {
                case RegionTopLeft:
                    break;
                case RegionBottomLeft:
                    [self scrollRectToVisible:CGRectMake(0, self.contentSize.height-self.frame.size.height, self.frame.size.width, self.frame.size.height) animated:NO];
                    break;
                case RegionTopRight:
                    [self scrollRectToVisible:CGRectMake(self.contentSize.width-self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
                    break;
                case RegionBottomRight:
                    [self scrollRectToVisible:CGRectMake(self.contentSize.width-self.frame.size.width, self.contentSize.height-self.frame.size.height, self.frame.size.width, self.frame.size.height) animated:NO];
                    break;
                default:
                    break;
            }

            
            
            [UIView commitAnimations];
            max=YES;
            
        }
}

-(void)imageTapOnceAction:(UIGestureRecognizer*)recognizer
{
    if(_tapOnceAction&&_target&&[_target respondsToSelector:_tapOnceAction])
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [_target performSelector:_tapOnceAction withObject:recognizer.view];

#pragma clang diagnostic pop

}

#pragma -mark 私有方法
-(CGRect)getFrameForImageView
{
    CGSize  size=_imageView.image.size;
    float scale=size.height/size.width;
    int width;
    int height;
    if((self.frame.size.width)*scale<(self.frame.size.height))
    {
        width=self.frame.size.width;
        height=width*scale;
    }
    else
    {
        height=self.frame.size.height;
        width=height/scale;
    }
    CGRect rect=CGRectMake((self.frame.size.width-width)/2, (self.frame.size.height-height)/2, width, height);
    return rect;
}

-(LocationRegion)getLocationRegion:(CGPoint)point
{
    float width=self.frame.size.width;
    float height=self.frame.size.height;
    if(point.x<width/2)
    {
        if(point.y<height/2)
            return RegionTopLeft;
        else
            return RegionBottomLeft;
    }
    else
    {
        if(point.y<height/2)
            return RegionTopRight;
        else
            return RegionBottomRight;
    }
}

#pragma -mark 接口方法
-(id)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if(self)
    {
        _imageView=[[UIImageView alloc]initWithFrame:CGRectZero];
        [self addSubview:_imageView];
        UITapGestureRecognizer * tapOnce=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTapOnceAction:)];
        tapOnce.numberOfTapsRequired=1;
        tapOnce.numberOfTouchesRequired=1;
        [_imageView addGestureRecognizer:tapOnce];
        _imageView.userInteractionEnabled=YES;
        
        UITapGestureRecognizer* tapTwo=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTapTwoAction:)];
        tapTwo.numberOfTapsRequired=2;
        tapTwo.numberOfTouchesRequired=1;
        [tapOnce requireGestureRecognizerToFail:tapTwo];
        [_imageView addGestureRecognizer:tapTwo];
        
        
        UIPinchGestureRecognizer * pinch=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(imagePinchAction:)];
        [_imageView addGestureRecognizer:pinch];

        max=NO;
        _tapOnceAction=nil;
        _target=nil;
        self.contentSize=self.frame.size;
    }
    return self;
}

-(id)initWithImage:(UIImage*)image andFrame:(CGRect)frame
{
    self = [self initWithFrame:frame];
    if (self) {
        // Initialization code
        _imageView.frame=[self getFrameForImageView];
        _imageView.image=image;
    }
    return self;
}


-(void)setImage:(UIImage*)image
{
    // Initialization code
    _imageView.image=image;
    _imageView.frame=[self getFrameForImageView];
}

-(void)setImageWithURL:(NSString *)url
{
    [self setImageWithURL:url andSmallImage:nil];
}

-(void)setImageWithURL:(NSString*)url  andSmallImage:(UIImage*)image
{
    UIActivityIndicatorView *indicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicator.frame=CGRectMake((self.frame.size.width-20)/2, (self.frame.size.height-20)/2, 20, 20);
    [self addSubview:indicator];
    [indicator startAnimating];
    
    _imageView.image=image;
    _imageView.frame=[self getFrameForImageView];
    
    __weak UIImageView * wimage=_imageView;
    __weak HBImageScroller * wself=self;
    [_imageView setImageWithURL:url layout:UIImageViewLayoutNone placeholderImage:nil process:nil complete:^(UIImage * image, NSData * data, NSError * error, BOOL success) {
        if(!wself||!wimage)return;
        wimage.image=image;
        wimage.frame=[wself getFrameForImageView];
        [indicator stopAnimating];
    }];
}

-(void)addTarget:(id)target tapOnceAction:(SEL)action
{
    _target=target;
    _tapOnceAction=action;
}

-(void)reset
{
    _imageView.frame=[self getFrameForImageView];
    self.contentSize=self.frame.size;
}

@end
