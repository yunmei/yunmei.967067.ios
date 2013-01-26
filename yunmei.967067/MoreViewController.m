//
//  MoreViewController.m
//  yunmei.967067
//
//  Created by bevin chen on 12-11-7.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"更多", @"更多");
        self.navigationItem.title = @"齐鲁直销商城";
        [self.tabBarItem setImage:[UIImage imageNamed:@"tabbar_more"]];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
            [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_more"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_more_unselected"]];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section ==0)
    {
        return 1;
    }else if (section ==1){
        return 2;
    }else if (section ==2){
        return 3;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return @"官方网址";
    }else if (section ==1){
        return @"设置";
    }else if (section ==2){
        return @"帮助";
    }else{
        return @"";
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell.textLabel setFont:[UIFont systemFontOfSize:12.0]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(indexPath.section == 0)
    {
        cell.textLabel.text = @"http://www.967067.cn";
    }else if (indexPath.section ==1){
        if(indexPath.row == 0){
            cell.textLabel.text = @"清空缓存";
        }else{
            cell.textLabel.text = @"退出";
        }
    }else if (indexPath.section ==2){
        if(indexPath.row == 0){
            cell.textLabel.text = @"帮助手册";
        }else if (indexPath.row ==1){
            cell.textLabel.text = @"检查更新";
        }else {
            cell.textLabel.text = @"意见反馈";
        }
    }else{
        cell.textLabel.text = @"客服电话 : 967067";
        [cell.textLabel setFont:[UIFont systemFontOfSize:14.0]];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        if(indexPath.row ==0)
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"缓存已清除" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            if([UserModel checkLogin])
            {
                [UserModel logout];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"当前用户已退出!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您并没有登陆，不需要退出!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        }
    }else if (indexPath.section ==2)
    {
        if(indexPath.row == 0)
        {
            HelpWebViewController *helplistView = [[HelpWebViewController alloc]init];
            helplistView.requestString = [[NSURL alloc]initWithString:URL_HELP];
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:nil];
            self.navigationItem.backBarButtonItem = backItem;
            [self.navigationController pushViewController:helplistView animated:YES];
        }else if (indexPath.row ==1){
            
        }else{
            UserSurggestViewController *userSurggestView = [[UserSurggestViewController alloc]init];
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:nil];
            self.navigationItem.backBarButtonItem = backItem;
            [self.navigationController pushViewController:userSurggestView animated:YES];
        }
    }
}

@end
