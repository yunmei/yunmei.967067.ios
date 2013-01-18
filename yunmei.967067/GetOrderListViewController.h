//
//  GetOrderListViewController.h
//  yunmei.967067
//
//  Created by ken on 13-1-18.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMGlobal.h"
#import "MBProgressHUD.h"
#import "SBJson.h"
#import "UserModel.h"
#import "AppDelegate.h"
#import "orderFirstCell.h"
#import "orderSecondCell.h"
#import "orderThirdCell.h"
@interface GetOrderListViewController : UIViewController<
UITableViewDataSource,
UITableViewDelegate
>
@property (strong,nonatomic)NSMutableArray *orderListArray;
@property (strong, nonatomic) IBOutlet UITableView *OrderListTableView;

@end
