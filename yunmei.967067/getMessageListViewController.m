//
//  getMessageListViewController.m
//  yunmei.967067
//
//  Created by ken on 13-2-1.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import "getMessageListViewController.h"

@interface getMessageListViewController ()

@end

@implementation getMessageListViewController
@synthesize messageListTableView;
@synthesize messageListArray = _messageListArray;
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
    if([UserModel checkLogin])
    {
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        UserModel *user = [UserModel getUserModel];
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"user_getMessageList",@"act",user.session,@"sessionId",user.userid,@"userId", nil];
        MKNetworkOperation *op = [YMGlobal getOperation:params];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            NSLog(@"%@",[completedOperation responseString]);
            SBJsonParser *parser = [[SBJsonParser alloc]init];
            NSMutableDictionary *obj = [parser objectWithData:[completedOperation responseData]];
            if([[obj objectForKey:@"errorMessage"]isEqualToString:@"success"])
            {
                self.messageListArray = [obj objectForKey:@"data"];
                [self.messageListTableView reloadData];
            }
            if([self.messageListArray count] == 0)
            {
                self.messageListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            }
            [HUD hide:YES];
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            NSLog(@"%@",error);
            [HUD hide:YES];
        }
         ];
        [ApplicationDelegate.appEngine enqueueOperation:op];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.messageListArray count] == 0) {
        return 1;
    }else{
        return [self.messageListArray count];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.messageListArray count]==0)
    {
        static NSString *identifier = @"identifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell  == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.textLabel.text = @"没有站内信";
        return cell;
    }else{
        static NSString *identifier = @"identifier1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell  == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier];
        }
        NSMutableDictionary *obj = [self.messageListArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"标题:%@ (时间:%@)",[obj objectForKey:@"title"],[obj objectForKey:@"sendtime"]];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"来自:%@",[obj objectForKey:@"sender"]];
        return cell;
    }
}

-(NSMutableArray *)messageListArray
{
    if(_messageListArray == nil)
    {
        _messageListArray = [[NSMutableArray alloc]init];
    }
    return  _messageListArray;
}
- (void)viewDidUnload {
    [self setMessageListTableView:nil];
    [super viewDidUnload];
}
@end
