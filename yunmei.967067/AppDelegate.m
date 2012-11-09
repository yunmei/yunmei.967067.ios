//
//  AppDelegate.m
//  yunmei.967067
//
//  Created by bevin chen on 12-11-2.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "AppDelegate.h"

#import "IndexViewController.h"
#import "CategoryViewController.h"
#import "CartViewController.h"
#import "MyViewController.h"
#import "MoreViewController.h"

@implementation UINavigationBar (CustomNavigationBarImage)
- (void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed: @"navigation_bar_bg"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 创建5个NavigationController
    UINavigationController *indexNavController = [[UINavigationController alloc] initWithRootViewController:[[IndexViewController alloc] initWithNibName:@"IndexViewController" bundle:nil]];
    UINavigationController *categoryNavController = [[UINavigationController alloc] initWithRootViewController:[[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil]];
    UINavigationController *cartNavController = [[UINavigationController alloc] initWithRootViewController:[[CartViewController alloc] initWithNibName:@"CartViewController" bundle:nil]];
    UINavigationController *myNavController = [[UINavigationController alloc] initWithRootViewController:[[MyViewController alloc] initWithNibName:@"MyViewController" bundle:nil]];
    UINavigationController *moreNavController = [[UINavigationController alloc] initWithRootViewController:[[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:nil]];
    
    // 给每个NavigationController增加背景色
    [indexNavController.navigationBar setTintColor:[UIColor colorWithRed:237/255.0f green:144/255.0f blue:6/255.0f alpha:1]];
    if ([indexNavController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        [indexNavController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_bg"] forBarMetrics: UIBarMetricsDefault];
    }
    [categoryNavController.navigationBar setTintColor:[UIColor colorWithRed:237/255.0f green:144/255.0f blue:6/255.0f alpha:1]];
    if ([categoryNavController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        [categoryNavController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_bg"] forBarMetrics: UIBarMetricsDefault];
    }
    [cartNavController.navigationBar setTintColor:[UIColor colorWithRed:237/255.0f green:144/255.0f blue:6/255.0f alpha:1]];
    if ([cartNavController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        [cartNavController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_bg"] forBarMetrics: UIBarMetricsDefault];
    }
    [myNavController.navigationBar setTintColor:[UIColor colorWithRed:237/255.0f green:144/255.0f blue:6/255.0f alpha:1]];
    if ([myNavController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        [myNavController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_bg"] forBarMetrics: UIBarMetricsDefault];
    }
    [moreNavController.navigationBar setTintColor:[UIColor colorWithRed:237/255.0f green:144/255.0f blue:6/255.0f alpha:1]];
    if ([moreNavController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        [moreNavController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_bg"] forBarMetrics: UIBarMetricsDefault];
    }
    
    // 初始化UITabBarController
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[indexNavController, categoryNavController, cartNavController, myNavController, moreNavController];

    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
 {
 }
 */

/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
 {
 }
 */
@end
