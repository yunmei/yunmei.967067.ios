//
//  getMessageListViewController.h
//  yunmei.967067
//
//  Created by ken on 13-2-1.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMGlobal.h"
#import "SBJson.h"
#import "MBProgressHUD.h"
#import "UserModel.h"
#import "AppDelegate.h"
@interface getMessageListViewController : UIViewController<
UITableViewDataSource,
UITableViewDelegate
>
@property (strong, nonatomic) IBOutlet UITableView *messageListTableView;
@property(strong,nonatomic)NSMutableArray *messageListArray;
@end
