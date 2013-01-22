//
//  MyFavorViewController.h
//  yunmei.967067
//
//  Created by ken on 13-1-22.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
#import "YMGlobal.h"
#import "SBJson.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "GoodsInfoViewController.h"
@interface MyFavorViewController : UIViewController<
UITableViewDataSource,
UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *MyFavorTableView;
@property (strong,nonatomic) NSMutableArray *goodsIdArr;
@property(strong,nonatomic)NSMutableArray *goodsInforArr;
@end
