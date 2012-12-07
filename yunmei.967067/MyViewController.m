//
//  MyViewController.m
//  yunmei.967067
//
//  Created by bevin chen on 12-11-7.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"我的商城", @"我的商城");
        self.navigationItem.title = @"我的商城";
        [self.tabBarItem setImage:[UIImage imageNamed:@"tabbar_my"]];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
            [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_my"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_my_unselected"]];
        }
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

@end
