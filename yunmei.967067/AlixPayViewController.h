//
//  AlixPayViewController.h
//  yunmei.967067
//
//  Created by ken on 13-1-25.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlixPay.h"
#import "AlixPayResult.h"
#import "AlixPayOrder.h"
#import "YMGlobal.h"
#import "MBProgressHUD.h"
#import "SBJson.h"
#import "AppDelegate.h"
@interface AlixPayViewController : UIViewController<UIAlertViewDelegate>
//商品名称
@property(strong,nonatomic)NSString *subject;
//商品描述
@property(strong,nonatomic)NSString *body;
//商品金额
@property(strong,nonatomic)NSString *total_fee;
//订单号
@property(strong,nonatomic)NSString *out_trade_no;
@property(strong,nonatomic)NSString *sign;
@end
