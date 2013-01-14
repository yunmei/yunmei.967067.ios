//
//  AddAddressViewController.h
//  yunmei.967067
//
//  Created by ken on 13-1-10.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuartzCore/QuartzCore.h"
#import "YMUIButton.h"
#import "YMGlobal.h"
#import "MBProgressHUD.h"
#import "SBJson.h"
#import "AppDelegate.h"
#import "OrderEditViewController.h"
@interface AddAddressViewController : UIViewController<
    UITableViewDataSource,
    UITableViewDelegate,
    UITextFieldDelegate,
    UIPickerViewDataSource,
    UIPickerViewDelegate
>
@property (strong, nonatomic) IBOutlet UITableView *addressTableView;
@property(strong,nonatomic)UITextField *goodsOwner;
@property(strong,nonatomic)UITextField *telephone;
@property(strong,nonatomic)UITextField *addressInDetail;
@property(strong,nonatomic)UITextField *zipCode;
@property(strong,nonatomic)UIButton *provinceBtn;
@property(strong,nonatomic)UIButton *cityBtn;
@property(strong,nonatomic)UIButton *countyBtn;
@property(strong,nonatomic)UITapGestureRecognizer *tapGestureRecgnizer;
@property(strong,nonatomic)UIPickerView *picker;
@property(strong,nonatomic)NSMutableArray *provinceArr;
@property(strong,nonatomic)NSMutableArray *cityArr;
@property(strong,nonatomic)NSMutableArray *countyArr;
@property(strong,nonatomic)NSMutableArray *provinceIdArr;
@property(strong,nonatomic)NSMutableArray *provinceNameArr;
@property(strong,nonatomic)NSMutableArray *cityIdArr;
@property(strong,nonatomic)NSMutableArray *cityNameArr;
@property(strong,nonatomic)NSMutableArray *countyIdArr;
@property(strong,nonatomic)NSMutableArray *countyNameArr;
@property(strong,nonatomic)UIToolbar *confirmToolBar;
@end
