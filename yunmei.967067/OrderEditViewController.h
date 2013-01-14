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
#import "AddAddressViewController.h"
#import "YMGlobal.h"
#import "GetOrderIdViewController.h"
@interface OrderEditViewController : UIViewController<
UITableViewDataSource,
UITableViewDelegate,
UITextFieldDelegate
>

@property (strong, nonatomic) IBOutlet UITableView *orderTableView;
@property (strong,nonatomic)NSMutableArray *goodsInfoList;
@property(strong,nonatomic)NSMutableArray *checkRadioArray;
@property(strong,nonatomic)UITextField *orderRemarkFeild;
@property(strong,nonatomic)UITapGestureRecognizer *tapGestureRecgnizer;
@property(strong,nonatomic)NSMutableDictionary *addressDic;
@property(strong,nonatomic)NSString *countPay;
@end
