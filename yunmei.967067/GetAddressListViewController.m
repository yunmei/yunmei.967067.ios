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
@synthesize userAddressArr = _userAddressArr;
@synthesize selectedAddrId;
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
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.userAddressArr count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSMutableDictionary *oneAddress = [self.userAddressArr objectAtIndex:indexPath.row];
    UILabel * addrLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 270, 30)];
    [addrLable setText:[@"地址:" stringByAppendingString:[oneAddress objectForKey:@"addr"]]];
    [addrLable setFont:[UIFont systemFontOfSize:12.0]];
    [addrLable setNumberOfLines:0];
    UILabel *nameLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 37, 270, 30)];
    [nameLable setText:[@"收货人:" stringByAppendingString:[oneAddress objectForKey:@"name"]]];
    [nameLable setFont:[UIFont systemFontOfSize:12.0]];
    UILabel *zipLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 70, 270, 30)];
    [zipLable setText:[@"邮编:" stringByAppendingString:[oneAddress objectForKey:@"zip"]]];
    [zipLable setFont:[UIFont systemFontOfSize:12.0]];
    [cell addSubview:addrLable];
    [cell addSubview:nameLable];
    [cell addSubview:zipLable];
return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *selectedAddress = [self.userAddressArr objectAtIndex:indexPath.row];
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

-(NSMutableArray *)userAddressArr
{
    if(_userAddressArr == nil)
    {
        _userAddressArr = [[NSMutableArray alloc]init];
    }
    return _userAddressArr;
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
