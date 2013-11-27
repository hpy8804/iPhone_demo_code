//
//  HBTalkTableViewController.m
//  HBTalkBubble
//
//  Created by weqia on 13-8-23.
//  Copyright (c) 2013年 hb. All rights reserved.
//

#import "HBTalkTableViewController.h"
#import "HBTalkTableViewTextLeftCell.h"
#import "HBTalkTableViewImageLeftCell.h"
#import "HBTalkTableViewImageRightCell.h"
#import "HBTalkTableViewTextRightCell.h"


@interface HBTalkTableViewController ()
{
    NSMutableArray * talks;
}
@end

@implementation HBTalkTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    talks=[NSMutableArray array];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    NSDate * date=[NSDate date];
    long long time=[date timeIntervalSince1970];
    time-=20*60;
    HBTalkData * talk=[[HBTalkData alloc]init];
    talk.contents=@"wo shi shui [大笑]";
    talk.contentType=HBTalkDataContentTypeText;
    talk.fromSelf=NO;
    talk.dataStatu=HBTalkDataStatuNormal;
    talk.timeInterval=[NSString stringWithFormat:@"%lld",time];
    [talks addObject:talk];
    
    talk=[[HBTalkData alloc]init];
    talk.contents=@"[足球][太阳][发怒][偷笑]";
    talk.contentType=HBTalkDataContentTypeText;
    talk.fromSelf=YES;
    talk.dataStatu=HBTalkDataStatuNormal;
    talk.timeInterval=[NSString stringWithFormat:@"%lld",time];
    [talks addObject:talk];
    
    talk=[[HBTalkData alloc]init];
    talk.contents=@"http://image.tianjimedia.com/uploadImages/2013/228/KT0X2XI3X9Z9.jpg";
    talk.contentType=HBTalkDataContentTypeImage;
    talk.fromSelf=NO;
    talk.dataStatu=HBTalkDataStatuShouldDownLoad;
    talk.timeInterval=[NSString stringWithFormat:@"%lld",time+1*60];
    [talks addObject:talk];
    
    talk=[[HBTalkData alloc]init];
    talk.contents=@"http://image.tianjimedia.com/uploadImages/2013/231/KJQIZSVQ013Q.jpg";
    talk.contentType=HBTalkDataContentTypeImage;
    talk.fromSelf=YES;
    talk.dataStatu=HBTalkDataStatuShouldDownLoad;
    talk.timeInterval=[NSString stringWithFormat:@"%lld",time+7*60];
    [talks addObject:talk];
    
    talk=[[HBTalkData alloc]init];
    talk.contents=@"wo shi shui [发怒]";
    talk.contentType=HBTalkDataContentTypeText;
    talk.fromSelf=NO;
    talk.dataStatu=HBTalkDataStatuNormal;
    talk.timeInterval=[NSString stringWithFormat:@"%lld",time+7*60];
    [talks addObject:talk];
    
    talk=[[HBTalkData alloc]init];
    talk.contents=@"wo shi shui NI NI 打开飞机打开 地方的解放军[偷笑]";
    talk.contentType=HBTalkDataContentTypeText;
    talk.fromSelf=YES;
    talk.dataStatu=HBTalkDataStatuNormal;
    talk.timeInterval=[NSString stringWithFormat:@"%lld",time+13*60];
    [talks addObject:talk];
    
    talk=[[HBTalkData alloc]init];
    talk.contents=@"wo shi shui [偷笑]adlfalkdfaldsfjaldsfjalkdsjf;jwefioh;sdkf;ahdf;akjds;fkjaldsfjaldsjflajdslfjaodislladfjaldjfladjfladjflkajdflkajdslfkjadlf呢好好好的法律地方；阿大开发阿地方； 阿邓朴方q额为；可j阿的飞机；啊打开飞机阿地方科技阿迪弗兰克大家佛i；阿达收费拉大分拉岛附近wi额分可j阿迪；发啊d；分科技啊；地方爬到解放； 阿军队f；ka的；飞机啊；的飞机啊；的飞机；阿呆几分可；阿凯地方啊；地方啊；的飞机啊电风扇；";
    talk.contentType=HBTalkDataContentTypeText;
    talk.fromSelf=NO;
    talk.dataStatu=HBTalkDataStatuNormal;
    talk.timeInterval=[NSString stringWithFormat:@"%lld",time+13*60];
    [talks addObject:talk];
    
    talk=[[HBTalkData alloc]init];
    talk.contents=@"http://image.tianjimedia.com/uploadImages/2013/231/63K864T17E2J.jpg";
    talk.contentType=HBTalkDataContentTypeImage;
    talk.fromSelf=NO;
    talk.dataStatu=HBTalkDataStatuShouldDownLoad;
    talk.timeInterval=[NSString stringWithFormat:@"%lld",time+13*60];
    [talks addObject:talk];
    
    talk=[[HBTalkData alloc]init];
    talk.contents=@"http://image.tianjimedia.com/uploadImages/2013/231/L7M86I8303J3.jpg";
    talk.contentType=HBTalkDataContentTypeImage;
    talk.fromSelf=NO;
    talk.dataStatu=HBTalkDataStatuShouldDownLoad;
    talk.timeInterval=[NSString stringWithFormat:@"%lld",time+13*60];
    [talks addObject:talk];

    talk=[[HBTalkData alloc]init];
    talk.contents=@"http://image.tianjimedia.com/uploadImages/2013/231/63K864T17E2J.jpg";
    talk.contentType=HBTalkDataContentTypeImage;
    talk.fromSelf=NO;
    talk.dataStatu=HBTalkDataStatuShouldDownLoad;
    talk.timeInterval=[NSString stringWithFormat:@"%lld",time+13*60];
    [talks addObject:talk];

    talk=[[HBTalkData alloc]init];
    talk.contents=@"http://image.tianjimedia.com/uploadImages/2013/228/6J24DA72I68Q.jpg";
    talk.contentType=HBTalkDataContentTypeImage;
    talk.fromSelf=NO;
    talk.dataStatu=HBTalkDataStatuShouldDownLoad;
    talk.timeInterval=[NSString stringWithFormat:@"%lld",time+13*60];
    [talks addObject:talk];

    talk=[[HBTalkData alloc]init];
    talk.contents=@"http://image.tianjimedia.com/uploadImages/2013/228/6BLP0Y3V9X3A.jpg";
    talk.contentType=HBTalkDataContentTypeImage;
    talk.fromSelf=NO;
    talk.dataStatu=HBTalkDataStatuShouldDownLoad;
    talk.timeInterval=[NSString stringWithFormat:@"%lld",time+13*60];
    [talks addObject:talk];

    talk=[[HBTalkData alloc]init];
    talk.contents=@"http://image.tianjimedia.com/uploadImages/2013/228/AXCO5HYK7OX0.jpg";
    talk.contentType=HBTalkDataContentTypeImage;
    talk.fromSelf=NO;
    talk.dataStatu=HBTalkDataStatuShouldDownLoad;
    talk.timeInterval=[NSString stringWithFormat:@"%lld",time+13*60];
    [talks addObject:talk];

    
    talk=[[HBTalkData alloc]init];
    talk.contents=@"wo shi shui [偷笑] [偷笑]   [偷笑][偷笑][偷笑][偷笑][偷笑][偷笑]    [偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑]     adadf[]adfadfasdf[[]adfasdf     [偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑][偷笑]";
    talk.contentType=HBTalkDataContentTypeText;
    talk.fromSelf=YES;
    talk.dataStatu=HBTalkDataStatuShouldUpLoad;
    talk.timeInterval=[NSString stringWithFormat:@"%lld",time+18*60];
    [talks addObject:talk];

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
    return [talks count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HBTalkData * preData;
    if(indexPath.row>0)
        preData=[talks objectAtIndex:indexPath.row-1];
    HBTalkData * data=[talks objectAtIndex:indexPath.row];
    return  [HBTalkTableViewCell getHeightByContent:data preData:preData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HBTalkData * preData=nil;
    if(indexPath.row>0)
        preData=[talks objectAtIndex:indexPath.row-1];
    HBTalkData * data=[talks objectAtIndex:indexPath.row];
    
    if(data.contentType==HBTalkDataContentTypeText)
        return [self getTextCell:tableView data:data widthPreData:preData];
    else if(data.contentType==HBTalkDataContentTypeImage)
        return [self getImageCell:tableView data:data widthPreData:preData];
    else
        return nil;
}
-(UITableViewCell*) getTextCell:(UITableView*)tableView  data:(HBTalkData*)data widthPreData:(HBTalkData*)preData;
{
    HBTalkTableViewCell * cell=nil;
    if(data.fromSelf){
        cell=[tableView dequeueReusableCellWithIdentifier:@"textRightCell"];
        if(cell==nil)
            cell=[[HBTalkTableViewTextRightCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"textRightCell"];

    }else{
        cell=[tableView dequeueReusableCellWithIdentifier:@"textLeftCell"];
        if(cell==nil)
            cell=[[HBTalkTableViewTextLeftCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"textLeftCell"];
    }
    cell.preTalkData=preData;
    cell.talkData=data;
    [cell setContent];
    return cell;
    
}
-(UITableViewCell*) getImageCell:(UITableView*)tableView  data:(HBTalkData*)data widthPreData:(HBTalkData*)preData;
{
    HBTalkTableViewCell * cell=nil;
    if(data.fromSelf){
        cell=[tableView dequeueReusableCellWithIdentifier:@"imageRightCell"];
        if(cell==nil)
            cell=[[HBTalkTableViewImageRightCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"imageRightCell"];
       
    }else{
        cell=[tableView dequeueReusableCellWithIdentifier:@"imageLeftCell"];
        if(cell==nil)
            cell=[[HBTalkTableViewImageLeftCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"imageLeftCell"];
    }
    cell.preTalkData=preData;
    cell.talkData=data;
    [cell setContent];
    return cell;
}





#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
