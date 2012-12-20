//
//  MyViewController.m
//  yunmei.967067
//
//  Created by bevin chen on 12-11-7.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "MyViewController.h"
#import "UserModel.h"

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

- (void)viewWillAppear:(BOOL)animated
{
    if (![UserModel checkLogin]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"INeedToLogin" object:self];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(userLogout)];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)userLogout
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定要退出吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.tabBarController setSelectedIndex:0];
        [UserModel logout];
    }
}
@end
