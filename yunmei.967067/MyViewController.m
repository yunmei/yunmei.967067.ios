//
//  MyViewController.m
//  yunmei.967067
//
//  Created by bevin chen on 12-11-7.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController
@synthesize imageContainer = _imageContainer;
@synthesize nameLable = _nameLable;
@synthesize pointLable = _pointLable;
@synthesize moneyLable = _moneyLable;
@synthesize headImageView = _headImageView;
@synthesize selectTable = _selectTable;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"我的商城", @"我的商城");
        self.navigationItem.title = @"我的商城";
        [self.tabBarItem setImage:[UIImage imageNamed:@"tabbar_my"]];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
            [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_my"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_my_unselected"]];
        }
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (![UserModel checkLogin]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"INeedToLogin" object:self];
    }else{
        UserModel *user = [UserModel getUserModel];
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"user_getInfo",@"act",user.session,@"sessionId",user.userid,@"userId",nil];
        MKNetworkOperation *op = [YMGlobal getOperation:params];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            NSLog(@"%@",[completedOperation responseString]);
            SBJsonParser *parser = [[SBJsonParser alloc]init];
            NSMutableDictionary *obj = [parser objectWithData:[completedOperation responseData]];
            if([[obj objectForKey:@"errorMessage"]isEqualToString:@"success"])
            {
                NSMutableDictionary *data = [obj objectForKey:@"data"];
                [YMGlobal loadImage:[data objectForKey:@"img"] andImageView:self.headImageView];
                self.nameLable.text = [NSString stringWithFormat:@"用户名 : %@",[data objectForKey:@"username"]];
                self.moneyLable.text = [NSString stringWithFormat:@"余    额 : %@",[data objectForKey:@"money"]];
                self.pointLable.text = [NSString stringWithFormat:@"积    分 : %@",[data objectForKey:@"point"]];
            }
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            NSLog(@"%@",error);
        }];
        [ApplicationDelegate.appEngine enqueueOperation:op];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(userLogout)];

    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.headImageView];
    [self.view addSubview:self.nameLable];
    [self.view addSubview:self.moneyLable];
    [self.view addSubview:self.pointLable];
    [self.view addSubview:self.imageContainer];
    [self.view addSubview:self.selectTable];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(indexPath.row == 0)
        {
            cell.textLabel.text = @"我的订单";
            
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"我的收藏";
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"收货地址管理";
        }else if (indexPath.row ==3){
            cell.textLabel.text = @"站内信";
        }
    }
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)userLogout
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定要退出吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.tabBarController setSelectedIndex:0];
        [UserModel logout];
    }
}

-(UILabel *)nameLable
{
    if(_nameLable == nil)
    {
        _nameLable = [[UILabel alloc]initWithFrame:CGRectMake(105, 10, 200, 20)];
    }
    [_nameLable setFont:[UIFont systemFontOfSize:12.0]];
    return _nameLable;
}

-(UILabel *)pointLable
{
    if(_pointLable == nil)
    {
        _pointLable = [[UILabel alloc]initWithFrame:CGRectMake(105, 30, 200, 20)];
    }
    [_pointLable setFont:[UIFont systemFontOfSize:12.0]];
    return _pointLable;
}

-(UILabel *)moneyLable
{
    if(_moneyLable == nil)
    {
        _moneyLable = [[UILabel alloc]initWithFrame:CGRectMake(105, 50, 200, 20)];
    }
    [_moneyLable setFont:[UIFont systemFontOfSize:12.0]];
    return _moneyLable;
}

-(UIImageView *)headImageView
{
    if(_headImageView == nil)
    {
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    }
    [_headImageView setImage:[UIImage imageNamed:@"user"]];
    return _headImageView;
}

-(UITableView *)selectTable
{
    if(_selectTable == nil)
    {
        _selectTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 110, 320, 180) style:UITableViewStyleGrouped];
    }
    _selectTable.backgroundColor = [UIColor clearColor];
    _selectTable.delegate = self;
    _selectTable.dataSource = self;
    _selectTable.scrollEnabled = NO;
    return _selectTable;
}
@end
