//
//  RegisterViewController.m
//  yunmei.967067
//
//  Created by bevin chen on 12-12-12.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

@synthesize usernameTextField;
@synthesize passwordTextField;
@synthesize repasswordTextField;
@synthesize emailTextField;
@synthesize registerBtn;
@synthesize cancelBtn;
@synthesize tapGestureRecgnizer = _tapGestureRecgnizer;
bool agreedDelegate = YES;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"用户注册", @"用户注册");
        self.navigationItem.title = @"用户注册";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.registerBtn addTarget:self action:@selector(userRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn addTarget:self action:@selector(registerCancel) forControlEvents:UIControlEventTouchUpInside];
    UIButton *aggreementSelectButton = [[UIButton alloc]initWithFrame:CGRectMake(24, 206, 20, 20)];
    [aggreementSelectButton setBackgroundImage:[UIImage imageNamed:@"RadioButton-Selected"] forState:UIControlStateNormal];
    [aggreementSelectButton addTarget:self action:@selector(aggreeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *agreeString = [[UILabel alloc]initWithFrame:CGRectMake(45, 206, 40, 20)];
    [agreeString setText:@"同意"];
    [agreeString setBackgroundColor:[UIColor clearColor]];
    [agreeString setFont:[UIFont systemFontOfSize:14.0]];
    [self.view addSubview:agreeString];
    [self.view addSubview:aggreementSelectButton];
    self.registerTableView.backgroundView = nil;
    self.registerTableView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)agreementTextButtonPressed:(id)sender {
    LicenseViewController *lisenceView = [[LicenseViewController alloc]init];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:lisenceView animated:YES];
}



- (BOOL)userRegister
{
    NSString *regEx = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    NSRange r = [self.emailTextField.text rangeOfString:regEx options:NSRegularExpressionSearch];
    
    UIAlertView *alertView = [[UIAlertView alloc]init];
    if ([self.usernameTextField.text isEqualToString:@""] || self.usernameTextField.text == nil) {
        [self.usernameTextField becomeFirstResponder];
        alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写用户名！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alertView show];
    } else if ([self.usernameTextField.text length] < 4 || [self.usernameTextField.text length] > 20) {
        [self.usernameTextField becomeFirstResponder];
        alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名的长度应该为4-20个字符！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alertView show];
    } else if ([self.emailTextField.text isEqualToString:@""] || self.emailTextField.text == nil) {
        [self.emailTextField becomeFirstResponder];
        alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写您的邮箱！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alertView show];
    } else if (r.location == NSNotFound) {
        [self.emailTextField becomeFirstResponder];
        alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您填写的邮箱不正确！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alertView show];
    } else if ([self.passwordTextField.text isEqualToString:@""] || self.passwordTextField.text == nil) {
        [self.passwordTextField becomeFirstResponder];
        alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请填写您的密码！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alertView show];
    } else if ([self.passwordTextField.text length] < 6) {
        [self.passwordTextField becomeFirstResponder];
        alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"为了您的密码安全，请填写6位以上的密码！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alertView show];
    } else if (![self.passwordTextField.text isEqualToString:self.repasswordTextField.text]) {
        [self.repasswordTextField becomeFirstResponder];
        alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的两次密码填写不一致！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alertView show];
    }else if (!agreedDelegate){
        alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您同意注册协议！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alertView show];
    }else {
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.navigationController.view];
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"user_register",@"act",self.usernameTextField.text,@"username",self.passwordTextField.text,@"password",self.emailTextField.text,@"email", nil];
        MKNetworkOperation *op = [YMGlobal getOperation:params];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            SBJsonParser *parser = [[SBJsonParser alloc]init];
            NSMutableDictionary *obj = [parser objectWithData:[completedOperation responseData]];
            if([[obj objectForKey:@"errorMessage"]isEqualToString:@"success"])
            {
                NSMutableDictionary *data  = [obj objectForKey:@"data"];
                NSLog(@"%@",data);
                YMDbClass *db = [[YMDbClass alloc]init];
                if([db connect])
                {
                    NSString *query = [NSString stringWithFormat:@"insert into user values ('%@','%@','%@','%@','%@');",[data objectForKey:@"userId"],self.usernameTextField.text,self.passwordTextField.text,@"YES",[data objectForKey:@"sessionId"]];
                    if([db exec:query])
                    {
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }
                }
            }
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            NSLog(@"%@",error);
        }];
        [ApplicationDelegate.appEngine enqueueOperation:op];
        [hud hide:YES];
    }
    
    return YES;
}

- (void)registerCancel
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UserRespondsLogin" object:self userInfo:[NSMutableDictionary dictionaryWithObject:@"cancel" forKey:@"cancel"]];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    [self setUsernameTextField:nil];
    [self setPasswordTextField:nil];
    [self setRepasswordTextField:nil];
    [self setEmailTextField:nil];
    [self setRegisterBtn:nil];
    [self setCancelBtn:nil];
    [self setRegisterTableView:nil];
    [super viewDidUnload];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField.tag !=0)
    self.view.center = CGPointMake(160, 160);
    [self.view addGestureRecognizer:self.tapGestureRecgnizer];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.center = CGPointMake(160, 205);
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
    [self.repasswordTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
}

-(void)aggreeButtonPressed:(id)sender
{
    UIButton *agreeBtn = sender;
    if(agreedDelegate)
    {
        agreedDelegate = NO;
        [agreeBtn setBackgroundImage:[UIImage imageNamed:@"RadioButton-Unselected"] forState:UIControlStateNormal];
    }else{
        agreedDelegate = YES;
        [agreeBtn setBackgroundImage:[UIImage imageNamed:@"RadioButton-Selected"] forState:UIControlStateNormal];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
