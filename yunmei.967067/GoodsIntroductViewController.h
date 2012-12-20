//
//  GoodsIntroductViewController.h
//  yunmei.967067
//
//  Created by ken on 12-12-19.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "SBJson.h"
#import "YMGlobal.h"

@interface GoodsIntroductViewController : UIViewController<
    UITableViewDelegate,
    UITableViewDataSource,
    UIWebViewDelegate
>

@property(strong,nonatomic)UITableView *introTableView;
@property(strong,nonatomic)UIWebView *contentWebView;
@property(strong,nonatomic)UILabel *goodsIntroductTitle;
@property(strong,nonatomic)NSString *goodsId;
@end
