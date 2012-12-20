//
//  GoodsIntroductViewController.m
//  yunmei.967067
//
//  Created by ken on 12-12-19.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "GoodsIntroductViewController.h"

@interface GoodsIntroductViewController ()

@end

@implementation GoodsIntroductViewController
@synthesize contentWebView = _contentWebView;
@synthesize introTableView = _introTableView;
@synthesize goodsIntroductTitle = _goodsIntroductTitle;
@synthesize goodsId;
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
    [self.view addSubview:self.introTableView];
    [self.navigationController setTitle:@"商品详情介绍"];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"goods_getInfoByGoodsId", @"act",self.goodsId,@"id",nil];
    MKNetworkOperation *op = [YMGlobal getOperation:params];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSMutableDictionary *object = [parser objectWithData:[completedOperation responseData]];
        if([[object objectForKey:@"errorMessage"]isEqualToString:@"success"])
        {
            NSMutableArray *goodsInfoArr = [object objectForKey:@"data"];
            NSString *content = [[goodsInfoArr objectAtIndex:0]objectForKey:@"goodsInfo"];
            NSLog(@"%@",content);
            [self.contentWebView loadHTMLString:content baseURL:nil];
            [self.introTableView reloadData];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"%@",error);
    }];
    [hud hide:YES];
    [ApplicationDelegate.appEngine enqueueOperation:op];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section ==0)
    {
        return self.goodsIntroductTitle.frame.size.height+10;
    }else{
        return 285;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        static NSString *cellIndentifier = @"goodsTitleCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            [cell setSelectionStyle:UITableViewCellEditingStyleNone];
        }else{
            [cell addSubview:self.goodsIntroductTitle];
        }
    return cell;
    }else{
        static NSString *cellIndentifier = @"goodsIntroCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            [cell setSelectionStyle:UITableViewCellEditingStyleNone];
        }else{
            [cell addSubview:self.contentWebView];
        }
        return cell;
    }
}

-(UIWebView *)contentWebView
{
    if(_contentWebView == nil)
    {
        _contentWebView = [[UIWebView alloc]initWithFrame:CGRectMake(20, 5, 285, 275)];
        _contentWebView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        [_contentWebView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust = '50%'"];
    }
    return _contentWebView;
}

-(UITableView *)introTableView
{
    if(_introTableView == nil)
    {
        _introTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 410) style:UITableViewStyleGrouped];
        _introTableView.delegate = self;
        _introTableView.dataSource = self;
        //_introTableView. = UITableViewStysePlain;
    }
    return _introTableView;
}

-(UILabel *)goodsIntroductTitle
{
    if(_goodsIntroductTitle == nil)
    {
        _goodsIntroductTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 270, 60)];
        [_goodsIntroductTitle setFont:[UIFont systemFontOfSize:14.0]];
        [_goodsIntroductTitle setNumberOfLines:2];
    }
    return _goodsIntroductTitle;
}

@end
