//
//  OrderEditViewController.h
//  yunmei.967067
//
//  Created by ken on 13-1-8.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMDbClass.h"
#import "goodsInfoView.h"
#import "YMGlobal.h"
#import "GetOrderIdViewController.h"
#import "UserModel.h"
#import "GetAddressListViewController.h"
#import "PassValueDelegate.h"
#import "PassObjValueDelegate.h"
@interface OrderEditViewController : UIViewController<
UITableViewDataSource,
UITableViewDelegate,
UITextFieldDelegate,
PassValueDelegate,
PassObjValueDelegate
>

@property (strong, nonatomic) IBOutlet UITableView *orderTableView;
@property (strong,nonatomic)NSMutableArray *goodsInfoList;
@property(strong,nonatomic)NSMutableArray *checkRadioArray;
@property(strong,nonatomic)UITextField *orderRemarkFeild;
@property(strong,nonatomic)UITapGestureRecognizer *tapGestureRecgnizer;
@property(strong,nonatomic)NSMutableDictionary *addressDic;
@property(strong,nonatomic)NSString *countPay;
@property(strong,nonatomic)NSMutableArray *userAddressArr;
@property(strong,nonatomic)UILabel *goodsOwnerLable;
@property(strong,nonatomic)UILabel *zipIdLable;
@property(strong,nonatomic)UILabel *telephoneLable;
@property(strong,nonatomic)UILabel *displayAreaLable;
@end
