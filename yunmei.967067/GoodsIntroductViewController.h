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
#import <QuartzCore/QuartzCore.h>
#import "YMUIButton.h"

@interface GoodsIntroductViewController : UIViewController<
    UITableViewDelegate,
    UITableViewDataSource,
    UIWebViewDelegate
>

@property(strong,nonatomic)NSString *goodsId;
@property(strong,nonatomic)NSString *goodsName;
@property(strong,nonatomic)NSString *proPrice;
@property(strong,nonatomic)NSString *mkPrice;
@property(strong,nonatomic)NSString *proCode;
@property(strong,nonatomic)UIWebView *goodsIntroductWebView;
@property(strong,nonatomic)UITableView *goodsIntroductTableView;
@property(strong,nonatomic)UIButton *infoBtn;
@property(strong,nonatomic)UIButton *comBtn;
@property(strong,nonatomic)NSMutableArray *commentArr;
@property(assign,nonatomic)int chooseNum;
@end
