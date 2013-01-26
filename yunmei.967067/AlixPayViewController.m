//
//  AlixPayViewController.m
//  yunmei.967067
//
//  Created by ken on 13-1-25.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import "AlixPayViewController.h"

@interface AlixPayViewController ()

@end

@implementation AlixPayViewController
@synthesize subject;
@synthesize body;
@synthesize total_fee;
@synthesize out_trade_no;
@synthesize sign;
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
- (IBAction)nextStep:(id)sender {
    self.subject = @"齐鲁直销商城商品";
    self.body = @"齐鲁直销商城商品";
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"system_getSign", @"act",self.subject,@"subject",self.body,@"body",self.total_fee,@"total_fee",self.out_trade_no,@"out_trade_no",nil];
    MKNetworkOperation *op = [YMGlobal getOperation:params];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSMutableDictionary *obj = [parser objectWithData:[completedOperation responseData]];
        if([[obj objectForKey:@"errorMessage"]isEqualToString:@"success"])
        {
            NSMutableDictionary *data = [obj objectForKey:@"data"];
            NSString *content = [data objectForKey:@"content"];
            NSString *signString = [data objectForKey:@"sign"];
            NSLog(@"sign%@",signString);
            NSLog(@"url%@",content);
            self.sign = [signString stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
            self.sign = [sign stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
             self.sign = [sign stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
            //将签名和参数组合成调用支付宝安全支持的参数
            NSString *orderSpec = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"RSA\"",content,self.sign];
            NSLog(@"%@",orderSpec);
            AlixPay *alixpay = [AlixPay shared];
            int ret = [alixpay pay:orderSpec applicationScheme:@"yunmei.967067"];
            if(ret == kSPErrorAlipayClientNotInstalled)
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                              message:@"您还没有安装支付宝快捷支付，请先安装。"
                                                             delegate:self
            										cancelButtonTitle:@"确定"
            										otherButtonTitles:nil];
                [alert setTag:123];
                [alert show];
            }
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"%@",error);
    }];
    [ApplicationDelegate.appEngine enqueueOperation:op];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 123)
    {
        NSString * URLString = @"http://itunes.apple.com/cn/app/id535715926?mt=8";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
    }
}
@end
