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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    } else {
        
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
@end
