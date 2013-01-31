//
//  MoreViewController.h
//  yunmei.967067
//
//  Created by bevin chen on 12-11-7.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
#import "HelpWebViewController.h"
#import "UserSurggestViewController.h"
#import "Constants.h"
@interface MoreViewController : UIViewController<
UITableViewDataSource,
UITableViewDelegate,
UIAlertViewDelegate>
@property(strong,nonatomic)NSString *downloadURl;
@end
