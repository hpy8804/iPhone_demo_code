//
//  HBHttpTestViewController.m
//  MyTest
//
//  Created by weqia on 13-8-22.
//  Copyright (c) 2013年 weqia. All rights reserved.
//

#import "HBHttpTestViewController.h"
#import "UIImageView+HBHttpCache.h"
#import "HBHttpRequestCache.h"
@interface HBHttpTestViewController ()
{
    NSMutableArray * urls;
}

@end

@implementation HBHttpTestViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)clearCachesAction
{
    [HBHttpRequestCache clearCache];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    urls=[[NSMutableArray alloc]init];
    [urls addObject:@"http://www.feizl.com/upload2007/2013_02/130227014423722.jpg"];
    [urls addObject:@"http://www.feizl.com/upload2007/2013_02/130227014423723.jpg"];
    [urls addObject:@"http://www.feizl.com/upload2007/2013_02/130227014423721.jpg"];
    [urls addObject:@"http://www.feizl.com/upload2007/2013_02/130227014423722.jpg"];
    [urls addObject:@"http://www.feizl.com/upload2007/2013_02/130227014423725.jpg"];
    [urls addObject:@"http://image.tianjimedia.com/uploadImages/2013/231/KJQIZSVQ013Q.jpg"];
    [urls addObject:@"http://image.tianjimedia.com/uploadImages/2013/231/50F271716EQV.jpg"];
    [urls addObject:@"http://image.tianjimedia.com/uploadImages/2013/231/QK2902POS179.jpg"];
    [urls addObject:@"http://image.tianjimedia.com/uploadImages/2013/231/63K864T17E2J.jpg"];
    [urls addObject:@"http://image.tianjimedia.com/uploadImages/2013/231/GP214390RG3V.jpg"];
    [urls addObject:@"http://image.tianjimedia.com/uploadImages/2013/231/L7M86I8303J3.jpg"];
    [urls addObject:@"http://image.tianjimedia.com/uploadImages/2013/231/Y86BKHJ2E2UH.jpg"];
    [urls addObject:@"http://image.tianjimedia.com/uploadImages/2013/228/6J24DA72I68Q.jpg"];
    [urls addObject:@"http://image.tianjimedia.com/uploadImages/2013/228/6BLP0Y3V9X3A.jpg"];
    [urls addObject:@"http://image.tianjimedia.com/uploadImages/2013/228/AXCO5HYK7OX0.jpg"];
     [urls addObject:@"http://image.tianjimedia.com/uploadImages/2013/228/B42FNUVDT7CS.jpg"];
     [urls addObject:@"http://image.tianjimedia.com/uploadImages/2013/228/1OEU52FTY56T.jpg"];
     [urls addObject:@"http://image.tianjimedia.com/uploadImages/2013/228/8L1N4G79RA65.jpg"];
     [urls addObject:@"http://image.tianjimedia.com/uploadImages/2013/228/0JM239P58O4O.jpg"];
     [urls addObject:@"http://image.tianjimedia.com/uploadImages/2013/228/KT0X2XI3X9Z9.jpg"];
    

    [clearcache setTarget:self];
    [clearcache setAction:@selector(clearCachesAction)];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [urls count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    for(UIView * view in cell.contentView.subviews)
        [view removeFromSuperview];
    UIImageView  * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300, 130)];
    [imageView setImageWithCacheKey:[urls objectAtIndex:indexPath.row] layout:UIImageViewLayoutNone placeholderImage:[UIImage imageNamed:@"notice_default_bg.png"]];
    [cell.contentView addSubview:imageView];
    imageView.tag=1000;
    return cell;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;  
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(!decelerate){
        [self visibleCellShow];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self visibleCellShow];
}

-(void)visibleCellShow
{
    NSArray * cells=[self.tableView visibleCells];
    for(UITableViewCell * cell in cells){
        NSIndexPath * index=[self.tableView indexPathForCell:cell];
        UIImageView * imageView=(UIImageView *)[cell.contentView viewWithTag:1000];
        NSString * url=[urls objectAtIndex:index.row];
        
       [imageView setImageWithURL:url layout:UIImageViewLayoutNone placeholderImage:[UIImage imageNamed:@"notice_default_bg.png"]];
    }
}

@end
