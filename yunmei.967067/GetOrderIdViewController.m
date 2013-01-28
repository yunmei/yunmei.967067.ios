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
@synthesize payAmount;
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
    [self bindSqlist];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(GoBack:)];
    self.navigationItem.leftBarButtonItem = backItem;
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
            UILabel *orderSubmitSuccessLable = [[UILabel alloc]initWithFrame:CGRectMake(95, 180, 200, 30)];
            [orderSubmitSuccessLable setFont:[UIFont systemFontOfSize:14.0]];
            [orderSubmitSuccessLable setTextColor:[UIColor redColor]];
            [orderSubmitSuccessLable setText:@"订单提交成功"];
            UILabel *getOrderIdLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 210, 50, 30)];
            [getOrderIdLable setFont:[UIFont systemFontOfSize:14.0]];
            [getOrderIdLable setTextColor:[UIColor grayColor]];
            [getOrderIdLable setText:@"订单号:"];
            if(self.payOnline == YES){
                UIButton *goToPay = [[UIButton alloc]initWithFrame:CGRectMake(30, 260, 260, 30)];
                [goToPay setBackgroundImage:[UIImage imageNamed:@"btn_yellow"] forState:UIControlStateNormal];
                [goToPay setTitle:@"去支付" forState:UIControlStateNormal];
                [goToPay addTarget:self action:@selector(goPay:) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:goToPay];
            }
            [self.view addSubview:orderSubmitSuccessLable];
            [self.view addSubview:getOrderIdLable];
            [self.view addSubview:self.orderIdLable];
            YMDbClass *db = [[YMDbClass alloc]init];
            if([db connect])
            {
                NSString *query = [NSString stringWithFormat:@"delete from goodslist_car"];
                [db exec:query];
                [db close];
            }
        }else{
            UILabel *orderSubmitSuccessLable = [[UILabel alloc]initWithFrame:CGRectMake(95, 180, 200, 30)];
            [orderSubmitSuccessLable setFont:[UIFont systemFontOfSize:14.0]];
            [orderSubmitSuccessLable setTextColor:[UIColor redColor]];
            [orderSubmitSuccessLable setText:@"订单提交失败，请重新提交"];
            [self.view addSubview:orderSubmitSuccessLable];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"%@",error);
    }];
    [ApplicationDelegate.appEngine enqueueOperation:op];
    [hud hide:YES];
    UIImageView *orderSuccessImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ordersuccesslogo"]];
    UIView *imageContainer = [[UIView alloc]initWithFrame:CGRectMake(70, 60, 140, 140)];
    [imageContainer addSubview:orderSuccessImg];
    [self.view addSubview:imageContainer];

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
-(void)GoBack:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)goPay:(id)sender
{
    AlixPayViewController *alixPayView = [[AlixPayViewController alloc]initWithNibName:@"AlixPayViewController" bundle:nil];
    alixPayView.out_trade_no = self.orderIdLable.text;
    if(self.payAmount)
    {
        NSLog(@"payfee%@",self.payAmount);
        alixPayView.total_fee = self.payAmount;
        UINavigationController *alixNav = [[UINavigationController alloc]initWithRootViewController:alixPayView];
        [alixNav.navigationBar setTintColor:[UIColor colorWithRed:237/255.0f green:144/255.0f blue:6/255.0f alpha:1]];
        if([alixNav.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
        {
            [alixNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_bg"] forBarMetrics: UIBarMetricsDefault];
        }
        [self.navigationController presentModalViewController:alixNav animated:YES];
    }

}

-(void)bindSqlist
{
    YMDbClass *db = [[YMDbClass alloc]init];
    if([db connect])
    {
        NSString *query = [NSString stringWithFormat:@"SELECT goodsid ,goods_code,goods_name,goods_price,goods_store,proid,goods_count FROM goodslist_car;"];
         NSMutableArray* goodsInfoList = [db fetchAll:query];
        [db close];
        if([goodsInfoList count]>0)
        {
            float i = 0;
            for(NSMutableDictionary *o in goodsInfoList)
            {
                CGFloat multiPal = (float)([[o objectForKey:@"goods_count"] integerValue] *[[o objectForKey:@"goods_price"] floatValue]);
                i += multiPal;
            }
            self.payAmount = [NSString stringWithFormat:@"%.2f",i];
        }    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
