//
//  GetOrderIdViewController.m
//  yunmei.967067
//
//  Created by ken on 13-1-14.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import "GetOrderIdViewController.h"

@interface GetOrderIdViewController ()
@end

@implementation GetOrderIdViewController
@synthesize orderId;
@synthesize payOnline;
@synthesize orderParamsDic = _orderParamsDic;
@synthesize orderIdLable = _orderIdLable;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSMutableDictionary *params = self.orderParamsDic;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [params setObject:@"order_addOrder" forKey:@"act"];
    if([UserModel checkLogin])
    {
        UserModel *user = [UserModel getUserModel];
        [params setObject:user.userid forKey:@"userId"];
        [params setObject:user.session forKey:@"sessionId"];
    }
    MKNetworkOperation * op = [YMGlobal getOperation:params];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSMutableDictionary *obj = [parser objectWithData:[completedOperation responseData]];
        if([[obj objectForKey:@"errorMessage"]isEqualToString:@"success"])
        {
            NSMutableDictionary *data = [obj objectForKey:@"data"];
            [self.orderIdLable setText:[data objectForKey:@"orderid"]];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"%@",error);
    }];
    [ApplicationDelegate.appEngine enqueueOperation:op];
    [hud hide:YES];
    UIImageView *orderSuccessImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ordersuccesslogo"]];
    UIView *imageContainer = [[UIView alloc]initWithFrame:CGRectMake(70, 60, 140, 140)];
    [imageContainer addSubview:orderSuccessImg];
    UILabel *orderSubmitSuccessLable = [[UILabel alloc]initWithFrame:CGRectMake(95, 180, 200, 30)];
    [orderSubmitSuccessLable setFont:[UIFont systemFontOfSize:14.0]];
    [orderSubmitSuccessLable setTextColor:[UIColor redColor]];
    [orderSubmitSuccessLable setText:@"订单提交成功"];
    UILabel *getOrderIdLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 210, 50, 30)];
    [getOrderIdLable setFont:[UIFont systemFontOfSize:14.0]];
    [getOrderIdLable setTextColor:[UIColor grayColor]];
    [getOrderIdLable setText:@"订单号:"];

    if(self.payOnline == YES){
        UIButton *goToPay = [[UIButton alloc]initWithFrame:CGRectMake(30, 290, 260, 30)];
        [goToPay setBackgroundImage:[UIImage imageNamed:@"btn_yellow"] forState:UIControlStateNormal];
        [goToPay setTitle:@"去支付" forState:UIControlStateNormal];
        [self.view addSubview:goToPay];
    }
    [self.view addSubview:imageContainer];
    [self.view addSubview:orderSubmitSuccessLable];
    [self.view addSubview:getOrderIdLable];
    [self.view addSubview:self.orderIdLable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableDictionary *)orderParamsDic
{
    if(_orderParamsDic == nil)
    {
        _orderParamsDic = [[NSMutableDictionary alloc]init];
    }
    return _orderParamsDic;
}

-(UILabel *)orderIdLable
{
    if(_orderIdLable == nil)
    {
        _orderIdLable = [[UILabel alloc]initWithFrame:CGRectMake(78, 210, 210, 30)];
        [_orderIdLable setFont:[UIFont systemFontOfSize:14.0]];
        [_orderIdLable setTextColor:[UIColor redColor]];
    }
    return _orderIdLable;
}
@end
