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
@synthesize goodsId;
@synthesize goodsName;
@synthesize proCode;
@synthesize proPrice;
@synthesize mkPrice;
@synthesize goodsIntroductTableView = _goodsIntroductTableView;
@synthesize goodsIntroductWebView = _goodsIntroductWebView;
@synthesize infoBtn;
@synthesize comBtn;
@synthesize commentArr =_commentArr;
int chooseNum = 1;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(UIWebView *)goodsIntroductWebView
{
    if(_goodsIntroductWebView == nil)
    {
        _goodsIntroductWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 133, 320, 475)];
    }
    return _goodsIntroductWebView;
}

-(NSMutableArray *)commentArr
{
    if(_commentArr == nil)
    {
        _commentArr = [[NSMutableArray alloc]init];
    }
    return _commentArr;
}

-(UITableView *)goodsIntroductTableView
{
    if(_goodsIntroductTableView == nil)
    {
        _goodsIntroductTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 133, 320, 275) style:UITableViewStylePlain];
        _goodsIntroductTableView.delegate = self;
        _goodsIntroductTableView.dataSource = self;
    }
    return _goodsIntroductTableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setTitle:@"商品详情介绍"];
    [self.view setBackgroundColor:[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0]];
    UILabel *goodsNameLable = [[UILabel alloc]initWithFrame:CGRectMake(6,0,320,48)];
    [goodsNameLable setBackgroundColor:[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0]];
    [goodsNameLable setText:self.goodsName];
    [goodsNameLable setFont:[UIFont systemFontOfSize:18.0]];//5 39 93 25
    [self.view addSubview:goodsNameLable];
    //商品价格
    UILabel *goodsPriceLable = [[UILabel alloc]initWithFrame:CGRectMake(8, 39, 93, 25)];
    [goodsPriceLable setBackgroundColor:[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0]];
    NSString *yang = @"￥";
    [goodsPriceLable setText:[yang stringByAppendingString:self.proPrice]];
    [goodsPriceLable setFont:[UIFont systemFontOfSize:17.0]];
    [goodsPriceLable setTextColor:[UIColor redColor]];
    [self.view addSubview:goodsPriceLable];
    //市场价格
    NSString *chiZ = @"市场价:￥";
    UILabel *mkGoodsPriceLable = [[UILabel alloc]initWithFrame:CGRectMake(110, 39, 140, 25)];
    [mkGoodsPriceLable setBackgroundColor:[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0]];
    [mkGoodsPriceLable setText:[chiZ stringByAppendingString:self.mkPrice]];
    [mkGoodsPriceLable setFont:[UIFont systemFontOfSize:16.0]];
    [mkGoodsPriceLable setTextColor:[UIColor grayColor]];
    [self.view addSubview:mkGoodsPriceLable];
    //商品编号
    UILabel *goodsCodeLable = [[UILabel alloc]initWithFrame:CGRectMake(5, 70, 180, 25)];
    NSString *chiC = @"商品编号:";
    [goodsCodeLable setBackgroundColor:[UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0]];
    [goodsCodeLable setText:[chiC stringByAppendingString:self.proCode]];
    [goodsCodeLable setFont:[UIFont systemFontOfSize:14.0]];
    [goodsCodeLable setTextColor:[UIColor grayColor]];
    [self.view addSubview:goodsCodeLable];
    

    //商品详情
    self.infoBtn = [YMUIButton CreateSizeButton:@"商品详情" CGFrame:CGRectMake(0, 100, 103, 33)];
    self.infoBtn .tag = 1;
    [self.infoBtn  setBackgroundColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0]];
    [self.infoBtn .layer setBorderWidth:1.0];
    if(chooseNum ==1)
    {
        [self.infoBtn .layer setBorderWidth:0.0];
        [self.infoBtn  setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
        [self.view addSubview:self.goodsIntroductWebView];
    }
    [self.infoBtn .layer setBorderColor:[YMUIButton CreateCGColorRef:170 greenNumber:170 blueNumber:170 alphaNumber:1.0]];
    [self.infoBtn  addTarget:self action:@selector(infoPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.infoBtn ];
    //商品评论
    self.comBtn = [YMUIButton CreateSizeButton:@"商品评论" CGFrame:CGRectMake(103, 100, 103, 33)];
    comBtn.tag = 2;
    [self.comBtn setBackgroundColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0]];
    [self.comBtn.layer setBorderWidth:1.0];
    [self.comBtn.layer setBorderColor:[YMUIButton CreateCGColorRef:170 greenNumber:170 blueNumber:170 alphaNumber:1.0]];
    [self.comBtn addTarget:self action:@selector(comPressed:) forControlEvents:UIControlEventTouchUpInside];
    if(chooseNum ==2)
    {
        [self.comBtn .layer setBorderWidth:0.0];
        [self.comBtn  setBackgroundColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]];
        [self.view addSubview:self.goodsIntroductTableView];
    }
    [self.view addSubview:self.comBtn];
    //生成一根灰色的棒
    UIButton *paramBtn = [YMUIButton CreateSizeButton:@"" CGFrame:CGRectMake(0, 100, 320, 1)];
    [paramBtn.layer setBorderColor:[YMUIButton CreateCGColorRef:170 greenNumber:170 blueNumber:170 alphaNumber:1.0]];
    [self.view addSubview:paramBtn];
    //请求webView数据
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"goods_getInfoByGoodsId", @"act",self.goodsId,@"goodsId",nil];
        MKNetworkOperation *op = [YMGlobal getOperation:params];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            SBJsonParser *parser = [[SBJsonParser alloc]init];
            NSMutableDictionary *object = [parser objectWithData:[completedOperation responseData]];
            if([[object objectForKey:@"errorMessage"]isEqualToString:@"success"])
            {
                NSMutableDictionary *goodsInfoDic = [object objectForKey:@"data"];
                NSString * intro = [goodsInfoDic objectForKey:@"goodsInfo"];
                [self.goodsIntroductWebView loadHTMLString:intro baseURL:nil];
                [self.goodsIntroductWebView reload];
            }
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            NSLog(@"%@",error);
        }];
        [hud hide:YES];
        [ApplicationDelegate.appEngine enqueueOperation:op];
    //请求tableView数据
    NSMutableDictionary *tableParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"goods_getCommentList",@"act",self.goodsId,@"goodsId",nil];
    MKNetworkOperation *tableOp = [YMGlobal getOperation:tableParams];
    [tableOp addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJsonParser *parserTable = [[SBJsonParser alloc]init];
        NSMutableDictionary *objectTable = [parserTable objectWithData:[completedOperation responseData]];
        if([[objectTable objectForKey:@"errorMessage"]isEqualToString:@"success"])
        {
            //将获取的商品评论存入属性；
            self.commentArr = [objectTable objectForKey:@"data"];
            [self.goodsIntroductTableView reloadData];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"%@",error);
    }];
    [ApplicationDelegate.appEngine enqueueOperation:tableOp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.commentArr count];
}

-(GLfloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //根据内容来确定每个row的高度
    NSString *comValue = [[self.commentArr objectAtIndex:indexPath.row]objectForKey:@"commentContent"];
    CGSize sizeToFit = [comValue sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(280.0, 999.0) lineBreakMode:UILineBreakModeCharacterWrap];
    return  sizeToFit.height+60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier  = @"cellForCom";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    NSString *comValue = [[self.commentArr objectAtIndex:indexPath.row]objectForKey:@"commentContent"];
    CGSize sizeToFit = [comValue sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(280.0, 999.0) lineBreakMode:UILineBreakModeCharacterWrap];
    UILabel * comContent = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 280, sizeToFit.height)];
    [comContent setTextColor:[UIColor grayColor]];
    comContent.text = comValue;
    comContent.font = [UIFont systemFontOfSize:14.0];
    comContent.lineBreakMode = UILineBreakModeCharacterWrap;
    comContent.numberOfLines = 0;
    UILabel *nickLable = [[UILabel alloc]initWithFrame:CGRectMake(10, sizeToFit.height+25, 160, 32)];
    nickLable.text = [[self.commentArr objectAtIndex:indexPath.row]objectForKey:@"nickname"];
    nickLable.font = [UIFont systemFontOfSize:15.0];
    UILabel *dateTime = [[UILabel alloc]initWithFrame:CGRectMake(170, sizeToFit.height+25, 160, 32)];
    dateTime.text = [[self.commentArr objectAtIndex:indexPath.row]objectForKey:@"commentTime"];
    dateTime.font = [UIFont systemFontOfSize:14.0];
    [dateTime setTextColor:[UIColor grayColor]];
    [cell addSubview:comContent];
    [cell addSubview:nickLable];
    [cell addSubview:dateTime];
    return cell;
}

-(void)infoPressed:(id)sender
{
    [self.comBtn.layer setBorderWidth:1.0];
    [self.infoBtn.layer setBorderWidth:0.0];
    [self.infoBtn  setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    [self.comBtn  setBackgroundColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0]];
    [self.goodsIntroductTableView removeFromSuperview];
    [self.view addSubview:self.goodsIntroductWebView];
}

-(void)comPressed:(id)sender
{
    [self.comBtn.layer setBorderWidth:0.0];
    [self.comBtn  setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    [self.infoBtn.layer setBorderWidth:1.0];
    [self.infoBtn  setBackgroundColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0]];
    [self.goodsIntroductWebView removeFromSuperview];
    [self.view addSubview:self.goodsIntroductTableView ];
}






@end
