//
//  MyFavorViewController.m
//  yunmei.967067
//
//  Created by ken on 13-1-22.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import "MyFavorViewController.h"

@interface MyFavorViewController ()

@end

@implementation MyFavorViewController
@synthesize MyFavorTableView;
@synthesize goodsIdArr;
@synthesize goodsInforArr;
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
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.navigationController.view];
        UserModel *user = [UserModel getUserModel];
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"user_getFavoriteList",@"act",user.session,@"sessionId",user.userid ,@"userId",nil];
        MKNetworkOperation *op = [YMGlobal getOperation:params];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            SBJsonParser *parser = [[SBJsonParser alloc]init];
            NSMutableDictionary *obj = [parser objectWithData:[completedOperation responseData]];
            if([[obj objectForKey:@"errorMessage"]isEqualToString:@"success"])
            {
                self.goodsIdArr = [[NSMutableArray alloc]initWithArray:[obj objectForKey:@"data"]];
                [self bindGoodsInfo];
            }else{
                UIView * vainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
                [vainView setBackgroundColor:[UIColor whiteColor]];
                UILabel *messageLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
                [messageLable setText:@"没有收藏记录"];
                [vainView addSubview:messageLable];
                [self.view addSubview:vainView];
            }
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            NSLog(@"%@",error);
        }];
        [ApplicationDelegate.appEngine enqueueOperation:op];
        [hud hide:YES];
    }
}

//绑定商品信息
-(void)bindGoodsInfo
{
    if([self.goodsIdArr count]>0)
    {
        NSLog(@"arr%@",self.goodsIdArr);
        NSString *goodsIdsAppending = @"";
        int i = 1;
        for(NSMutableDictionary *o in self.goodsIdArr)
        {
            goodsIdsAppending = [goodsIdsAppending stringByAppendingString:[o objectForKey:@"goodsId"]];
            if(i != [self.goodsIdArr count])
            {
                goodsIdsAppending = [goodsIdsAppending stringByAppendingString:@","];
            }
            i++;
        }
        
        NSMutableDictionary *goodsIdParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"goods_getListById",@"act",goodsIdsAppending,@"goodsId", nil];
        MKNetworkOperation *op1 = [YMGlobal getOperation:goodsIdParams];
        [op1 addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            SBJsonParser *parser = [[SBJsonParser alloc]init];
            NSMutableDictionary *obj = [parser objectWithData:[completedOperation responseData]];
            if([[obj objectForKey:@"errorMessage"]isEqualToString:@"success"])
            {
                self.goodsInforArr = [[NSMutableArray alloc]initWithArray:[obj objectForKey:@"data"]];
                [self.MyFavorTableView reloadData];
            }
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            NSLog(@"%@",error);
        }];
        [ApplicationDelegate.appEngine enqueueOperation:op1];
    }else{
        NSLog(@"kong ");
        UIView * vainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
        UILabel *messageLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        [messageLable setText:@"记录为空"];
        [vainView addSubview:messageLable];
        [self.navigationController.view addSubview:vainView];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     return [self.goodsInforArr count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifer];
    }
    NSMutableDictionary *oneGoodsInfo = [self.goodsInforArr objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"goods_default"];
    [YMGlobal loadImage:[oneGoodsInfo objectForKey:@"imageUrl"] andImageView:cell.imageView];
    cell.textLabel.text = [oneGoodsInfo objectForKey:@"goodsName"];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@",[oneGoodsInfo objectForKey:@"goodsPrice"]];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
    cell.detailTextLabel.textColor = [UIColor redColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *oneGoods = [self.goodsInforArr objectAtIndex:indexPath.row];
    GoodsInfoViewController *goodsInfoView = [[GoodsInfoViewController alloc]init];
    goodsInfoView.goodsId = [oneGoods objectForKey:@"goodsId"];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:goodsInfoView animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSMutableDictionary *oneGoods = [self.goodsInforArr objectAtIndex:indexPath.row];
        [self.goodsInforArr removeObjectAtIndex:indexPath.row];
        if([UserModel checkLogin])
        {
            UserModel *user = [UserModel getUserModel];
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"user_delFavorite",@"act", user.session,@"sessionId",user.userid,@"userId",[oneGoods objectForKey:@"goodsId"],@"goodsId",nil];
            MKNetworkOperation *op = [YMGlobal getOperation:params];
            [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
                SBJsonParser *parser = [[SBJsonParser alloc]init];
                NSMutableDictionary *obj = [parser objectWithData:[completedOperation responseData]];
                if([[obj objectForKey:@"errorMessage"]isEqualToString:@"success"])
                {
                    
                }
            } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
                NSLog(@"%@",error);
            }];
            [ApplicationDelegate.appEngine enqueueOperation:op];
        }
        [self.MyFavorTableView reloadData];
    }
}

- (void)viewDidUnload {
    [self setMyFavorTableView:nil];
    [super viewDidUnload];
}
@end
