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
    self.navigationItem.title = @"收货人信息";
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleBordered target:self action:@selector(addAddress:)];
    self.navigationItem.rightBarButtonItem = addBtn;
    [self bindSqlite];
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
    if(indexPath.row == 0)
    {
        [cell.selectedLog setImage:[UIImage imageNamed:@"RadioButton-Selected"]];
        self.seletedImage = cell.selectedLog;
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
    [self.navigationController popViewControllerAnimated:YES];
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
@end
