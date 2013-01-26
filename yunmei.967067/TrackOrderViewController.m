//
//  TrackOrderViewController.m
//  yunmei.967067
//
//  Created by ken on 13-1-26.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import "TrackOrderViewController.h"

@interface TrackOrderViewController ()

@end

@implementation TrackOrderViewController
@synthesize trackOrderTableView;
@synthesize logi_code;
@synthesize logi_name;
@synthesize logi_no;
@synthesize trackData;
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
    if([self.logi_no isEqualToString:@""])
    {
        
    }else{
        UserModel *user = [UserModel getUserModel];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"order_getOrderTrack",@"act",user.userid,@"userId",user.session,@"sessionId",@"6e8c9096714875db",@"id",self.logi_code,@"com",self.logi_no,@"nu",nil];
        MKNetworkOperation *op = [YMGlobal getOperation:params];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            SBJsonParser *parser = [[SBJsonParser alloc]init];
            NSMutableDictionary *obj = [parser objectWithData:[completedOperation responseData]];
            if([[obj objectForKey:@"errorMessage"]isEqualToString:@"sucess"])
            {
                NSMutableArray *data = [[obj objectForKey:@"data"] objectForKey:@"data"];
                self.trackData = [[NSMutableArray alloc]initWithArray:data];
                [self.trackOrderTableView reloadData];
            }
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            NSLog(@"%@",error);
        }];
        [ApplicationDelegate.appEngine enqueueOperation:op];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.trackData == nil)
    {
        return 1;
    }else{
        return [self.trackData count];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.trackData == nil)
    {
        static NSString *identifier = @"identifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.textLabel.text = @"没有数据";
        return cell;
    }else{
        static NSString *identifier = @"identifier1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }
        cell.textLabel.text = [[self.trackData objectAtIndex:indexPath.row] objectForKey:@"context"];
        cell.detailTextLabel.text = [[self.trackData objectAtIndex:indexPath.row] objectForKey:@"time"];
        return cell;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTrackOrderTableView:nil];
    [super viewDidUnload];
}


@end
