//
//  CartViewController.m
//  yunmei.967067
//
//  Created by bevin chen on 12-11-7.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "CartViewController.h"

@interface CartViewController ()

@end

@implementation CartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"购物车", @"购物车");
        self.navigationItem.title = @"购物车";
        [self.tabBarItem setImage:[UIImage imageNamed:@"tabbar_cart"]];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
            [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_cart"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_cart_unselected"]];
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
