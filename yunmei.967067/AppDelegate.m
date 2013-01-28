//
//  AppDelegate.m
//  yunmei.967067
//
//  Created by bevin chen on 12-11-2.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "AppDelegate.h"
#import "AlixPay.h"
#import "AlixPayResult.h"
#import <sys/utsname.h>

@implementation UINavigationBar (CustomNavigationBarImage)
- (void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed: @"navigation_bar_bg"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end

@implementation AppDelegate

@synthesize appEngine;

//- (BOOL)isSingleTask{
//	struct utsname name;
//	uname(&name);
//	float version = [[UIDevice currentDevice].systemVersion floatValue];//判定系统版本。
//	if (version < 4.0 || strstr(name.machine, "iPod1,1") != 0 || strstr(name.machine, "iPod2,1") != 0) {
//		return YES;
//	}
//	else {
//		return NO;
//	}
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"begin");
    // 创建MKNetworkEngine
    self.appEngine= [[MKNetworkEngine alloc] initWithHostName:API_HOSTNAME customHeaderFields:nil];
    [self.appEngine useCache];
    
    // 应用启动时停留时间
    //[NSThread sleepForTimeInterval:5];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // 创建5个NavigationController
    UINavigationController *indexNavController = [[UINavigationController alloc] initWithRootViewController:[[IndexViewController alloc] initWithNibName:@"IndexViewController" bundle:nil]];
    UINavigationController *categoryNavController = [[UINavigationController alloc] initWithRootViewController:[[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil]];
    UINavigationController *cartNavController = [[UINavigationController alloc] initWithRootViewController:[[CartViewController alloc] initWithNibName:@"CartViewController" bundle:nil]];
    cartNavController.tabBarItem.tag =3;
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
        self.tabBarController.delegate = self;
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    // NSNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openSearchView:) name:@"INeedToSearch" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToSearch:) name:@"GoToSearch" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openLoginView:) name:@"INeedToLogin" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userRespondsLogin:) name:@"UserRespondsLogin" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goToAddress:) name:@"addOneAddress" object:nil];
    [self statisGoodsCar:self.tabBarController];
//    /*
//	 *单任务handleURL处理
//	 */
//	if ([self isSingleTask]) {
//		NSURL *url = [launchOptions objectForKey:@"UIApplicationLaunchOptionsURLKey"];
//		
//		if (nil != url) {
//			[self parseURL:url application:application];
//		}
//	}
    return YES;
}

- (void)openSearchView:(NSNotification *)note
{
    GoodsSearchViewController *searchView = [[GoodsSearchViewController alloc]init];
    [self.tabBarController.selectedViewController presentModalViewController:searchView animated:YES];
}

- (void)goToSearch:(NSNotification *)note
{
    UINavigationController *viewController = (UINavigationController *)self.tabBarController.selectedViewController;
    NSString *keywords = [[note userInfo]objectForKey:@"keywords"];
    
    GoodsListViewController *goodsListViewController = [[GoodsListViewController alloc]init];
    goodsListViewController.requestDataType = @"search";
    goodsListViewController.requestId = keywords;
    UILabel *itemTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 170, 44)];
    itemTitle.textAlignment = UITextAlignmentCenter;
    itemTitle.text = [NSString stringWithFormat:@"关键字\"%@\"的产品列表", keywords];
    itemTitle.font = [UIFont systemFontOfSize:14.0];
    itemTitle.backgroundColor = [UIColor clearColor];
    itemTitle.textColor = [UIColor whiteColor];
    goodsListViewController.navigationItem.titleView = itemTitle;
    [viewController pushViewController:goodsListViewController animated:(YES)];
}

- (void)openLoginView:(NSNotification *)note
{
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil]];
    [navController.navigationBar setTintColor:[UIColor colorWithRed:237/255.0f green:144/255.0f blue:6/255.0f alpha:1]];
    if ([navController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        [navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_bg"] forBarMetrics: UIBarMetricsDefault];
    }
    [self.tabBarController.selectedViewController presentModalViewController:navController animated:YES];
}

-(void)goToAddress:(NSNotification *)note
{
    AddAddressViewController *addAdressView = [[AddAddressViewController alloc]initWithNibName:@"AddAddressViewController" bundle:nil];
    UINavigationController *orderNav = [[UINavigationController alloc]initWithRootViewController:addAdressView];
    [orderNav.navigationBar setTintColor:[UIColor colorWithRed:237/255.0f green:144/255.0f blue:6/255.0f alpha:1]];
    if([orderNav.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [orderNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_bg"] forBarMetrics: UIBarMetricsDefault];
    }
    [self.tabBarController.selectedViewController presentModalViewController:orderNav animated:YES];
}
- (void)userRespondsLogin:(NSNotification *)note
{
    if ([[note userInfo]objectForKey:@"cancel"]) {
        if (self.tabBarController.selectedIndex == 3) {
            [self.tabBarController setSelectedIndex:0];
        }
    }
}

//统计购物车数量
-(void)statisGoodsCar:(UITabBarController *)tabBarController
{
    YMDbClass *db = [[YMDbClass alloc]init];
    if([db connect])
    {
        [[tabBarController.tabBar.items objectAtIndex:2] setBadgeValue:[db count_sum:@"goodslist_car" tablefiled:@"goods_count"]];
    }
    [db close];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
	
    NSLog(@"getget");
	//[self parseURL:url application:application];
    
	return YES;
}

-(void)parseURL:(NSURL *)url application:(UIApplication *)application
{
	AlixPay *alixpay = [AlixPay shared];
	AlixPayResult *result = [alixpay handleOpenURL:url];
//	if (result) {
//		//是否支付成功
////		if (9000 == result.statusCode) {
////			/*
////			 *用公钥验证签名
////			 */
////			id<DataVerifier> verifier = CreateRSADataVerifier([[NSBundle mainBundle] objectForInfoDictionaryKey:@"RSA public key"]);
////			if ([verifier verifyString:result.resultString withSign:result.signString]) {
////				UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
////																	 message:result.statusMessage
////																	delegate:nil
////														   cancelButtonTitle:@"确定"
////														   otherButtonTitles:nil];
////				[alertView show];
////				[alertView release];
////			}//验签错误
////			else {
////				UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
////																	 message:@"签名错误"
////																	delegate:nil
////														   cancelButtonTitle:@"确定"
////														   otherButtonTitles:nil];
////				[alertView show];
////				[alertView release];
////			}
////		}
////		//如果支付失败,可以通过result.statusCode查询错误码
////		else {
////			UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示"
////																 message:result.statusMessage
////																delegate:nil
////													   cancelButtonTitle:@"确定"
////													   otherButtonTitles:nil];
////			[alertView show];
////			[alertView release];
////		}
////		
//	}
//        NSLog(@"%@",result);
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




 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
 {
     if(viewController.tabBarItem.tag ==3)
     {
        
         UINavigationController *CarNavigation = (UINavigationController *)viewController;
         [CarNavigation popToRootViewControllerAnimated:YES];
         CartViewController *carView = (CartViewController *)CarNavigation.topViewController;
         [carView setDataSource];
     }
 }


/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
 {
 }
 */
@end
