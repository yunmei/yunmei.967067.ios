//
//  MyViewController.h
//  yunmei.967067
//
//  Created by bevin chen on 12-11-7.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMGlobal.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "UserModel.h"
@interface MyViewController : UIViewController <
UIAlertViewDelegate,
UITableViewDataSource,
UITableViewDelegate>

@property(strong,nonatomic)UIView *imageContainer;
@property(strong,nonatomic)UILabel *nameLable;
@property(strong,nonatomic)UILabel *pointLable;
@property(strong,nonatomic)UILabel *moneyLable;
@property(strong,nonatomic)UIImageView *headImageView;
@property(strong,nonatomic)UITableView *selectTable;
@end
