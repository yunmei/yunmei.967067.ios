//
//  LoginViewController.m
//  yunmei.967067
//
//  Created by bevin chen on 12-12-12.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize usernameTextField;
@synthesize passwordTextField;
@synthesize registerBtn;
@synthesize loginBtn;
@synthesize tapGestureRecgnizer = _tapGestureRecgnizer;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"用户登陆", @"用户登陆");
        self.navigationItem.title = @"用户登陆";
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    if([UserModel checkLogin])
    {
        [self dismissModalViewControllerAnimated:YES];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"登陆"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(userLogin)];
    self.navigationItem.rightBarButtonItem = buttonItem;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                 style:UIBarButtonItemStyleBordered
                                                                target:self
                                                                action:@selector(userCancel)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [self.registerBtn addTarget:self action:@selector(userRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn addTarget:self action:@selector(userLogin) forControlEvents:UIControlEventTouchUpInside];
    [UserModel createTable];
}

- (bool)userLogin
{
    if (usernameTextField.text == nil || passwordTextField.text == nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示信息" message:@"用户名或密码不能为空" delegate:self cancelButtonTitle:@"确 认" otherButtonTitles:nil];
        [alert show];
        return YES;
    }
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"user_login" forKey:@"act"];
    [params setObject:usernameTextField.text forKey:@"username"];
    [params setObject:[passwordTextField.text md5] forKey:@"password"];
    MKNetworkOperation* op = [YMGlobal getOperation:params];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSMutableDictionary *object = [parser objectWithData:[completedOperation responseData]];
        [HUD hide:YES];
        UserModel *userModel = [[UserModel alloc]init];
        userModel.password = passwordTextField.text;
        userModel.username = usernameTextField.text;
        if ([[object objectForKey:@"errorMessage"] isEqualToString:@"success"]) {
            userModel.session = [[object objectForKey:@"data"]objectForKey:@"sessionId"];
            userModel.userid = [[object objectForKey:@"data"]objectForKey:@"userId"];
            userModel.isLogin = @"YES";
            } else {
            userModel.isLogin = @"NO";
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示信息" message:@"用户名或密码错误，请重新登陆" delegate:self cancelButtonTitle:@"确 认" otherButtonTitles:nil];
            [alert show];
            passwordTextField.text = @"";
        }
        YMDbClass *db = [[YMDbClass alloc]init];
        if([db connect])
        {
            [UserModel clearTable];
            NSString *sql = [NSString stringWithFormat:@"insert into user values ('%@','%@','%@','%@','%@');", userModel.userid, userModel.username, userModel.password, userModel.isLogin, userModel.session];
            [db exec:sql];
            [db close];
        }
        if ([userModel.isLogin isEqualToString:@"YES"]) {
            [self dismissModalViewControllerAnimated:YES];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"Error:%@", error);
        [HUD hide:YES];
    }];
    [ApplicationDelegate.appEngine enqueueOperation: op];
    return YES;
}

- (void)userCancel
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UserRespondsLogin" object:self userInfo:[NSMutableDictionary dictionaryWithObject:@"cancel" forKey:@"cancel"]];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)userRegister
{
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"登陆"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:nil];
    self.navigationItem.backBarButtonItem = buttonItem;
    RegisterViewController *registerViewController = [[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setUsernameTextField:nil];
    [self setPasswordTextField:nil];
    [self setLoginBtn:nil];
    [self setRegisterBtn:nil];
    [super viewDidUnload];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGFloat height = self.view.center.y;
    CGFloat width = self.view.frame.size.width;
    [self.view setCenter:CGPointMake(width/2, height-100)];
    [self.view addGestureRecognizer:self.tapGestureRecgnizer];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    CGFloat height = self.view.frame.size.height/2;
    CGFloat width = self.view.frame.size.width/2;
    [self.view setCenter:CGPointMake(width, height)];
    [self.view removeGestureRecognizer:self.tapGestureRecgnizer];
}
-(UITapGestureRecognizer *)tapGestureRecgnizer
{
    if(_tapGestureRecgnizer == nil)
    {
        _tapGestureRecgnizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard:)];
        _tapGestureRecgnizer.numberOfTapsRequired = 1;
    }
    return  _tapGestureRecgnizer;
}

-(void)hideKeyBoard:(id)sender
{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
