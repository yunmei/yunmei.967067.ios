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
    UILabel *OrderIdLable = [[UILabel alloc]initWithFrame:CGRectMake(75, 210, 210, 30)];
    [OrderIdLable setFont:[UIFont systemFontOfSize:14.0]];
    [OrderIdLable setTextColor:[UIColor redColor]];
    [OrderIdLable setText:self.orderId];
    if(self.payOnline == YES){
        UIButton *goToPay = [[UIButton alloc]initWithFrame:CGRectMake(30, 290, 260, 30)];
        [goToPay setBackgroundImage:[UIImage imageNamed:@"btn_yellow"] forState:UIControlStateNormal];
        [goToPay setTitle:@"去支付" forState:UIControlStateNormal];
        [self.view addSubview:goToPay];
    }
    [self.view addSubview:imageContainer];
    [self.view addSubview:orderSubmitSuccessLable];
    [self.view addSubview:getOrderIdLable];
    [self.view addSubview:OrderIdLable];
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

@end
