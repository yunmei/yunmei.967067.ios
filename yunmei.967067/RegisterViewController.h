//
//  RegisterViewController.h
//  yunmei.967067
//
//  Created by bevin chen on 12-12-12.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMGlobal.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "YMDbClass.h"
#import "LicenseViewController.h"
@interface RegisterViewController : UIViewController<
UITextFieldDelegate,
UITableViewDataSource,
UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *repasswordTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UIButton *registerBtn;
@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property(strong,nonatomic)UITapGestureRecognizer *tapGestureRecgnizer;

@property (strong, nonatomic) IBOutlet UITableView *registerTableView;


@end
