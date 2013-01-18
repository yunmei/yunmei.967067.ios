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
            NSLog(@"%@",self.orderListArray);
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
    NSLog(@"%i",goods.count);
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
        return 60;
    }else if (indexPath.row == ([[[self.orderListArray objectAtIndex:indexPath.section] objectForKey:@"goods"]count] +1)){
        return 30;
    }else
    {
        return 100;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
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
@end
