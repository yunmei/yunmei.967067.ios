//
//  LoginViewController.h
//  yunmei.967067
//
//  Created by bevin chen on 12-12-12.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "SBJson.h"
#import "YMGlobal.h"
#import "UserModel.h"
#import "MBProgressHUD.h"
#import "YMDbClass.h"
@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIButton *registerBtn;
@property(strong,nonatomic)UITapGestureRecognizer *tapGestureRecgnizer;
@end
