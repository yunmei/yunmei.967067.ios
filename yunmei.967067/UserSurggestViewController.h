//
//  UserSurggestViewController.h
//  yunmei.967067
//
//  Created by ken on 13-1-23.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "YMUIButton.h"
#import "YMGlobal.h"
#import "MBProgressHUD.h"
#import "SBJson.h"
#import "AppDelegate.h"
@interface UserSurggestViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *surggestTitle;
@property (strong, nonatomic) IBOutlet UITextView *surggestContent;
@property (strong, nonatomic) IBOutlet UITextField *surggestLink;
@property (strong,nonatomic)  UITapGestureRecognizer *tapGrestuer;
@end
