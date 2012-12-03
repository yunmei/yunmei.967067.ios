//
//  GoodsInfoViewController.h
//  yunmei.967067
//
//  Created by ken on 12-12-3.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMGlobal.h"
#import "MBProgressHUD.h"
#import "SBJson.h"
#import "AppDelegate.h"
#import "GoodsModel.h"

@interface GoodsInfoViewController : UIViewController

@property(strong, nonatomic)NSString *goodsId;
@property(strong, nonatomic)GoodsModel *goodsModel;
@end
