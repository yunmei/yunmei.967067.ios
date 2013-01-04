//
//  CartViewController.h
//  yunmei.967067
//
//  Created by bevin chen on 12-11-7.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMDbClass.h"
#import "CarCell.h"
#import <QuartzCore/QuartzCore.h>
@interface CartViewController : UIViewController<
    UITableViewDataSource,
    UITableViewDelegate,
    UITextFieldDelegate
>

@property(strong,nonatomic)NSMutableArray *goodsList;
@property(strong,nonatomic)UITableView *goodsTableView;
@property(strong,nonatomic)NSMutableArray *textFieldList;
@property(strong,nonatomic)UIToolbar *controlInput;
@property(strong,nonatomic)UITextField *fistReTextFeild;
@property(strong,nonatomic)UILabel *payCount;

-(void)setDataSource;
@end
