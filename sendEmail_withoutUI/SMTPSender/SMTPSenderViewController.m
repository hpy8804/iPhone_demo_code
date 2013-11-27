//
//  SMTPSenderViewController.m
//  SMTPSender
//
//  Created by 吴晓明 on 13-1-23.
//  Copyright (c) 2013年 吴 晓明. All rights reserved.
//

#import "SMTPSenderViewController.h"
#import <CFNetwork/CFNetwork.h>
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"

void alert(NSString* msg);

@interface SMTPSenderViewController ()
- (IBAction)sendEmail:(id)sender;

@end

@implementation SMTPSenderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendEmail:(id)sender {
    
    SKPSMTPMessage *testMsg = [[SKPSMTPMessage alloc] init];
    //发送者
    testMsg.fromEmail = @"abovelink@163.com";
    //发送给
    testMsg.toEmail = @"465738515@qq.com";
    //抄送联系人列表，如：@"664742641@qq.com;1@qq.com;2@q.com;3@qq.com"
    testMsg.ccEmail = @"";
    //密送联系人列表，如：@"664742641@qq.com;1@qq.com;2@q.com;3@qq.com"
    testMsg.bccEmail = @"";
    //发送有些的发送服务器地址
    testMsg.relayHost = @"smtp.163.com";
    //需要鉴权
    testMsg.requiresAuth = YES;
    //发送者的登录账号
    testMsg.login = @"abovelink@163.com";
    //发送者的登录密码
    testMsg.pass = @"wanlian1";
    //邮件主题
    testMsg.subject = [NSString stringWithCString:"来自iphone socket的测试邮件" encoding:NSUTF8StringEncoding ];
    
    testMsg.wantsSecure = YES; // smtp.gmail.com doesn't work without TLS!
    
    // Only do this for self-signed certs!
    // testMsg.validateSSLChain = NO;
    testMsg.delegate = self;
    
    //主题
    NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,
                               @"This is a test message.\r\n支持中文。",kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    
    //附件
    NSString *vcfPath = [[NSBundle mainBundle] pathForResource:@"video.jpg" ofType:@""];
    NSData *vcfData = [NSData dataWithContentsOfFile:vcfPath];
    
    //附件图片文件
    NSDictionary *vcfPart = [[NSDictionary alloc ]initWithObjectsAndKeys:@"text/directory;\r\n\tx-unix-mode=0644;\r\n\tname=\"video.jpg\"",kSKPSMTPPartContentTypeKey,
                             @"attachment;\r\n\tfilename=\"video.jpg\"",kSKPSMTPPartContentDispositionKey,[vcfData encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
    //附件音频文件
    NSString *wavPath = [[NSBundle mainBundle] pathForResource:@"push" ofType:@"wav"];
    NSData *wavData = [NSData dataWithContentsOfFile:wavPath];
    NSDictionary *wavPart = [[NSDictionary alloc ]initWithObjectsAndKeys:@"text/directory;\r\n\tx-unix-mode=0644;\r\n\tname=\"push.wav\"",kSKPSMTPPartContentTypeKey,
                             @"attachment;\r\n\tfilename=\"push.wav\"",kSKPSMTPPartContentDispositionKey,[wavData encodeBase64ForData],kSKPSMTPPartMessageKey,@"base64",kSKPSMTPPartContentTransferEncodingKey,nil];
    testMsg.parts = [NSArray arrayWithObjects:plainPart,vcfPart,wavPart, nil];
    
    [testMsg send];
    

    
}

- (void)messageSent:(SKPSMTPMessage *)message
{
    [message release];
    
    //发送成功
    NSLog(@"delegate - message sent");
    alert(@"发送成功");
}

- (void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error
{
    [message release];
    
    //发送失败 
    NSLog(@"delegate - error(%d): %@", [error code], [error localizedDescription]);
    alert(@"发送失败");
}
@end


void alert(NSString* msg)
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}