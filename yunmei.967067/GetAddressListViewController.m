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
@synthesize seletedImage;
@synthesize ifThisViewComeFromMyCenter;
@synthesize imageArr = _imageArr;
@synthesize delegate;
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
    [self bindData];
   
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


-(void)bindData
{
    if([UserModel checkLogin])
    {
        UserModel *user = [UserModel getUserModel];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"user_getAddressList",@"act",user.session,@"sessionId",user.userid,@"userId", nil];
        MKNetworkOperation *op = [YMGlobal getOperation:params];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            SBJsonParser *parser = [[SBJsonParser alloc]init];
            NSMutableDictionary *obj = [parser objectWithData:[completedOperation responseData]];
            if([[obj objectForKey:@"errorMessage"]isEqualToString:@"success"])
            {
                self.userAddressArray = [obj objectForKey:@"data"];
                [self.AddressListTableView reloadData];
            }else{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"addOneAddress" object:self];

                }
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            NSLog(@"%@",error);
        }];
        [ApplicationDelegate.appEngine enqueueOperation:op];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.userAddressArray count]>0)
    {
        return [self.userAddressArray count];
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.userAddressArray count] >0)
    {
        static NSString *identifier = @"identifier";
        AddressCell *cell = (AddressCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[AddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSMutableDictionary *oneAddress = [self.userAddressArray objectAtIndex:indexPath.row];
        NSString *addressAppending = [NSString stringWithFormat:@"地址:%@%@%@%@",[oneAddress objectForKey:@"province"],[oneAddress objectForKey:@"city"],[oneAddress objectForKey:@"district"],[oneAddress objectForKey:@"addr"]];
        [cell.addrLable setText:addressAppending];
        [cell.addrLable setFont:[UIFont systemFontOfSize:12.0]];
        [cell.addrLable setNumberOfLines:0];
        [cell.nameLable setText:[@"收货人:" stringByAppendingString:[oneAddress objectForKey:@"name"]]];
        [cell.nameLable setFont:[UIFont systemFontOfSize:12.0]];
        [cell.zipLable setText:[@"邮编:" stringByAppendingString:[oneAddress objectForKey:@"zip"]]];
        [cell.zipLable setFont:[UIFont systemFontOfSize:12.0]];
        [cell addSubview:cell.addrLable];
        [cell addSubview:cell.nameLable];
        [cell addSubview:cell.zipLable];
        if([[oneAddress objectForKey:@"is_default"]isEqualToString:@"1"])
        {
            [cell.selectedLog setImage:[UIImage imageNamed:@"RadioButton-Selected"]];
            self.seletedImage = cell.selectedLog;
        }else{
            [cell.selectedLog setImage:[UIImage imageNamed:@"RadioButton-Unselected"]];
        }
        [cell addSubview:cell.selectedLog];
        return cell;
    }else{
        static NSString *identifier = @"identifierAnother";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.textLabel.text = @"用户地址列表为空，请添加地址";
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.seletedImage setImage:[UIImage imageNamed:@"RadioButton-Unselected"]];
    
   // MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.navigationController.view];
    NSMutableDictionary *selectedAddress = [self.userAddressArray objectAtIndex:indexPath.row];
    UserModel *user = [UserModel getUserModel];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"user_setToDef",@"act",user.session,@"sessionId",user.userid,@"userId",[selectedAddress objectForKey:@"addr_id"],@"addr_id", nil];
    MKNetworkOperation *op = [YMGlobal getOperation:params];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSMutableDictionary *obj = [parser objectWithData:[completedOperation responseData]];
        if([[obj objectForKey:@"errorMessage"]isEqualToString:@"success"])
        {
            [self bindData];
            [self.AddressListTableView reloadData];
            if(self.ifThisViewComeFromMyCenter)
            {
                [self dismissModalViewControllerAnimated:YES];
            }else{
                //调用自定义协议 在前一VC中实现这个协议
                [self.delegate passVlaue:selectedAddress];
                [self.navigationController popViewControllerAnimated:YES];
            }          
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"%@",error);
    }];
    [ApplicationDelegate.appEngine enqueueOperation:op];
    //[hud hide:YES];
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
        if(![[oneAddress objectForKey:@"addr_id"]isEqualToString:@""])
        {
            UserModel *user = [UserModel getUserModel];
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"user_delAddressInfo",@"act",user.session,@"sessionId",user.userid,@"userId",[oneAddress objectForKey:@"addr_id"],@"addr_id", nil];
            MKNetworkOperation *op = [YMGlobal getOperation:params];
            [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
                SBJsonParser *parser = [[SBJsonParser alloc]init];
                NSMutableDictionary *obj = [parser objectWithData:[completedOperation responseData]];
                if([[obj objectForKey:@"errorMessage"]isEqualToString:@"success"])
                {
                    NSLog(@"删除成功");
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

-(NSMutableArray *)imageArr
{
    if(_imageArr == nil)
    {
        _imageArr = [[NSMutableArray alloc]init];
    }
    return _imageArr;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
