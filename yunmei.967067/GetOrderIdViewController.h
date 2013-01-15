//
//  GetOrderIdViewController.h
//  yunmei.967067
//
//  Created by ken on 13-1-14.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMGlobal.h"
#import "SBJson.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "UserModel.h"
@interface GetOrderIdViewController : UIViewController
@property(strong,nonatomic)NSString *orderId;
@property BOOL payOnline;
@property(strong,nonatomic)NSMutableDictionary *orderParamsDic;
@property(strong,nonatomic)UILabel *orderIdLable;
@end
