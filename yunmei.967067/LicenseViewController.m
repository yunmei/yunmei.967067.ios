//
//  LicenseViewController.m
//  yunmei.967067
//
//  Created by ken on 13-1-21.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import "LicenseViewController.h"

@interface LicenseViewController ()

@end

@implementation LicenseViewController

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
    NSString *licensePath = [[NSBundle mainBundle]pathForResource:@"license" ofType:@"html"];
    NSLog(@"%@",licensePath);
    NSData *licenseData = [[NSData alloc]initWithContentsOfFile:licensePath];
    NSString *licenseHTML = [[NSString alloc]initWithData:licenseData encoding:NSUTF8StringEncoding];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 416)];
    webView.backgroundColor = [UIColor whiteColor];
    [webView loadHTMLString:licenseHTML baseURL:[NSURL URLWithString:@"about:blank"]];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
