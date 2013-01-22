//
//  GetAddressListViewController.m
//  yunmei.967067
//
//  Created by ken on 13-1-15.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import "GetAddressListViewController.h"

@interface GetAddressListViewController ()

@end

@implementation GetAddressListViewController
@synthesize AddressListTableView;
@synthesize userAddressArray = _userAddressArray;
@synthesize selectedAddrId;
@synthesize seletedImage;
@synthesize ifThisViewComeFromMyCenter;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"bool%i",self.ifThisViewComeFromMyCenter);
    [self bindSqlite];
    [self.AddressListTableView reloadData];
    if([self.userAddressArray count]==0)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addOneAddress" object:self];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"收货人信息列表";
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleBordered target:self action:@selector(addAddress:)];
    self.navigationItem.rightBarButtonItem = addBtn;
    if(self.ifThisViewComeFromMyCenter)
    {
        UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backToMyCenter:)];
        self.navigationItem.leftBarButtonItem = leftBtn;
    }
}


-(void)bindSqlite
{
    YMDbClass *db = [[YMDbClass alloc]init];
    if([db connect])
    {
        NSString * query = [NSString stringWithFormat:@"select * from user_address"];
        [self.userAddressArray removeAllObjects];
        self.userAddressArray = [db fetchAll:query];
        NSLog(@"%@",self.userAddressArray);
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.userAddressArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    AddressCell *cell = (AddressCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil)
    {
        cell = [[AddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if([self.userAddressArray count] == 0)
    {
        [cell.addrLable setText:@"没有数据"];
        [cell.addrLable setFont:[UIFont systemFontOfSize:14.0]];
        [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [cell addSubview:cell.addrLable];
    }
    NSMutableDictionary *oneAddress = [self.userAddressArray objectAtIndex:indexPath.row];
    [cell.addrLable setText:[@"地址:" stringByAppendingString:[oneAddress objectForKey:@"addr"]]];
    [cell.addrLable setFont:[UIFont systemFontOfSize:12.0]];
    [cell.addrLable setNumberOfLines:0];
    [cell.nameLable setText:[@"收货人:" stringByAppendingString:[oneAddress objectForKey:@"name"]]];
    [cell.nameLable setFont:[UIFont systemFontOfSize:12.0]];
    [cell.zipLable setText:[@"邮编:" stringByAppendingString:[oneAddress objectForKey:@"zip"]]];
    [cell.zipLable setFont:[UIFont systemFontOfSize:12.0]];
    [cell addSubview:cell.addrLable];
    [cell addSubview:cell.nameLable];
    [cell addSubview:cell.zipLable];
    if([[oneAddress objectForKey:@"state"]isEqualToString:@"1"])
    {
        [cell.selectedLog setImage:[UIImage imageNamed:@"RadioButton-Selected"]];
    }else{
        [cell.selectedLog setImage:[UIImage imageNamed:@"RadioButton-Unselected"]];
    }
    [cell addSubview:cell.selectedLog];
return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.seletedImage setImage:[UIImage imageNamed:@"RadioButton-Unselected"]];
    NSMutableDictionary *selectedAddress = [self.userAddressArray objectAtIndex:indexPath.row];
    //调用自定义协议 在前一VC中实现这个协议
    [self.delegate passVlaue:selectedAddress];
    YMDbClass *db = [[YMDbClass alloc]init];
    if([db connect])
    {
        NSString *query1 = [NSString stringWithFormat:@"update user_address set state = '0' where state = '1';"];
        NSString * query2 = [NSString stringWithFormat:@"update user_address set state = '1'  where addr_id = '%@';",[selectedAddress objectForKey:@"addr_id"]];
        [db exec:query1];
        [db exec:query2];
        [db close];
        [self bindSqlite];
        [self.AddressListTableView reloadData];
    }
    if(self.ifThisViewComeFromMyCenter)
    {
        [self.parentViewController dismissModalViewControllerAnimated:YES];
    }else{

        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSMutableDictionary *oneAddress =[self.userAddressArray objectAtIndex:indexPath.row];
        YMDbClass *db = [[YMDbClass alloc]init];
        if([db connect])
        {
            NSString *query = [NSString stringWithFormat:@"delete from user_address where addr_id = '%@';",[oneAddress objectForKey:@"addr_id"]];
            if([db exec:query])
            {
                NSLog(@"数据库删除成功");
            };
        }
        if(![[oneAddress objectForKey:@"addr_id"]isEqualToString:@"0"])
        {
            
            NSLog(@"%@",oneAddress);
            UserModel *user = [UserModel getUserModel];
            NSLog(@"userId:%@",user.userid);
            NSLog(@"sessionId:%@",user.session);
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"user_delAddressInfo",@"act",user.session,@"sessionId",user.userid,@"userId",[oneAddress objectForKey:@"addr_id"],@"addr_id", nil];
            NSLog(@"地址:%@",[oneAddress objectForKey:@"addr"]);
            MKNetworkOperation *op = [YMGlobal getOperation:params];
            [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
                SBJsonParser *parser = [[SBJsonParser alloc]init];
                NSMutableDictionary *obj = [parser objectWithData:[completedOperation responseData]];
                if([[obj objectForKey:@"errorMessage"]isEqualToString:@"success"])
                {
                    NSLog(@"删除成功");
                    NSLog(@"%@",obj);
                }
                else{
                    NSLog(@"删除失败");
                }
            } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
                NSLog(@"%@",error);
            }];
            [ApplicationDelegate.appEngine enqueueOperation:op];
        }
        [self.userAddressArray removeObjectAtIndex:indexPath.row];
        [self.AddressListTableView reloadData];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setAddressListTableView:nil];
    [super viewDidUnload];
}

-(NSMutableArray *)userAddressArray
{
    if(_userAddressArray == nil)
    {
        _userAddressArray = [[NSMutableArray alloc]init];
    }
    return _userAddressArray;
}
-(void)addAddress:(id)sender
{
    AddAddressViewController *addAdressView = [[AddAddressViewController alloc]initWithNibName:@"AddAddressViewController" bundle:nil];
    UINavigationController *orderNav = [[UINavigationController alloc]initWithRootViewController:addAdressView];
    [orderNav.navigationBar setTintColor:[UIColor colorWithRed:237/255.0f green:144/255.0f blue:6/255.0f alpha:1]];
    if([orderNav.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [orderNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_bg"] forBarMetrics: UIBarMetricsDefault];
    }
    [self.navigationController presentModalViewController:orderNav animated:YES];
}

-(void)backToMyCenter:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
@end
