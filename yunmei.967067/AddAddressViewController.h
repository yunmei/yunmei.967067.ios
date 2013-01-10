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
@interface AddAddressViewController : UIViewController<
    UITableViewDataSource,
    UITableViewDelegate,
    UITextFieldDelegate
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
@end
