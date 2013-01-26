//
//  GetOrderListViewController.m
//  yunmei.967067
//
//  Created by ken on 13-1-18.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import "GetOrderListViewController.h"

@interface GetOrderListViewController ()

@end

@implementation GetOrderListViewController
@synthesize orderListArray = _orderListArray;
@synthesize OrderListTableView;
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
    self.navigationItem.title = @"我的订单列表";
    [self bindOrderData];
}

//绑定订单列表数据
-(void)bindOrderData
{
    UserModel *user = [UserModel getUserModel];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"order_getOrderList",@"act",user.userid,@"userId",user.session,@"sessionId", nil];
    MKNetworkOperation *op = [YMGlobal getOperation:param];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSMutableDictionary *obj = [parser objectWithData:[completedOperation responseData]];
        if([[obj objectForKey:@"errorMessage"]isEqualToString:@"success"])
        {
            self.orderListArray = [obj objectForKey:@"data"];
            [self.OrderListTableView reloadData];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"error");
    }];
    [ApplicationDelegate.appEngine enqueueOperation:op];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *goods = [[self.orderListArray objectAtIndex:section] objectForKey:@"goods"];
    return [goods count]+2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.orderListArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 70;
    }else if (indexPath.row == ([[[self.orderListArray objectAtIndex:indexPath.section] objectForKey:@"goods"]count] +1)){
        return 30;
    }else
    {
        return 100;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *oneOrder = [self.orderListArray objectAtIndex:indexPath.section];
    if(indexPath.row ==0)
    {
        static NSString *identifier = @"identifier1";
        orderFirstCell *cell = (orderFirstCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[orderFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        [cell.orderCode setText:[NSString stringWithFormat:@"订单号 : %@",[oneOrder objectForKey:@"orderId"]]];
        [cell.orderPay setText:[NSString stringWithFormat:@"订单金额 : %@",[oneOrder objectForKey:@"final_amount"]]];
        [cell.orderGenerateTime setText:[NSString stringWithFormat:@"下单时间 : %@",[oneOrder objectForKey:@"createtime"]]];
        cell.trackOrderBtn.tag = indexPath.section;
        [cell.trackOrderBtn addTarget:self action:@selector(trackOrder:) forControlEvents:UIControlEventTouchUpInside];
        [cell.orderCode setBackgroundColor:[UIColor clearColor]];
        [cell.orderPay setBackgroundColor:[UIColor clearColor]];
        [cell.orderGenerateTime setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:cell.orderCode];
        [cell addSubview:cell.orderPay];
        [cell addSubview:cell.orderGenerateTime];
        [cell addSubview:cell.trackOrderBtn];
        return cell;
    }else if (indexPath.row == ([[[self.orderListArray objectAtIndex:indexPath.section] objectForKey:@"goods"]count] +1)){
        static NSString *identifier = @"identifier2";
        orderThirdCell *cell = (orderThirdCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[orderThirdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier
                    ];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        if([[oneOrder objectForKey:@"ship_status"]isEqualToString:@"0"])
        {
            [cell.orderState setText:@"订单状态 : 未支付"];
        }else{
            [cell.orderState setText:@"订单状态 : 已支付"];
        }
        [cell.orderState setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:cell.orderState];
            return cell;
    }else{
        NSMutableArray *goodsArr = [oneOrder objectForKey:@"goods"];
        NSMutableDictionary *oneGoods = [goodsArr objectAtIndex:(indexPath.row -1)];
        static NSString *identifier = @"indentifier3";
        orderSecondCell *cell = (orderSecondCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[orderSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        [cell.goodsImg setImage:[UIImage imageNamed:@"goods_default"]];
        [YMGlobal loadImage:[oneGoods objectForKey:@"imageUrl"] andImageView:cell.goodsImg];
        [cell.goodsName setText:[oneGoods objectForKey:@"name"]];
        [cell.goodsName setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:cell.goodsName];
        [cell addSubview:cell.goodsImg];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserModel *user = [UserModel getUserModel];
    NSMutableDictionary *oneOrder = [self.orderListArray objectAtIndex:indexPath.section];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"order_getOrderInfo",@"act",user.session,@"sessionId",user.userid,@"userId",[oneOrder objectForKey:@"orderId"],@"orderId", nil];
    MKNetworkOperation *op = [YMGlobal getOperation:params];
    [op  addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSMutableDictionary *obj = [parser objectWithData:[completedOperation responseData]];
        if([[obj objectForKey:@"errorMessage"]isEqualToString:@"success"])
        {
            OrderDetailViewController *orderDetailView = [[OrderDetailViewController alloc]init];
            orderDetailView.orderData = [NSMutableDictionary dictionaryWithDictionary:[obj objectForKey:@"data"]];
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:nil];
            self.navigationItem.backBarButtonItem = backItem;
            [self.navigationController pushViewController:orderDetailView animated:YES];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"%@",error);
    }];
    [ApplicationDelegate.appEngine enqueueOperation:op];
}
-(NSMutableArray *)orderListArray
{
    if(_orderListArray == nil)
    {
        _orderListArray = [[NSMutableArray alloc]init];
    }
    return _orderListArray;
}
- (void)viewDidUnload {
    [self setOrderListTableView:nil];
    [super viewDidUnload];
}

//订单追踪
-(void)trackOrder:(id)sender
{
    UIButton *trackBtn = sender;
    NSLog(@"%i",trackBtn.tag);
}
@end
