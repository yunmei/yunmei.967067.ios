//
//  AppDelegate.h
//  yunmei.967067
//
//  Created by bevin chen on 12-11-2.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartViewController.h"
#import "IndexViewController.h"
#import "CategoryViewController.h"
#import "MyViewController.h"
#import "MoreViewController.h"
#import "GoodsSearchViewController.h"
#import "GoodsListViewController.h"
#import "LoginViewController.h"
#import "Constants.h"
#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) MKNetworkEngine *appEngine;

@end
