//
//  GoodsInfoViewController.m
//  yunmei.967067
//
//  Created by ken on 12-12-3.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "GoodsInfoViewController.h"

@interface GoodsInfoViewController ()


@end

@implementation GoodsInfoViewController
@synthesize goodsId;
@synthesize goodsModel = _goodsModel;
@synthesize goodsTableView;
@synthesize sizeBtn;

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
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.rightBarButtonItem = searchBtn;
    //NSLog(@"%@",[self goodsId]);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"goods_getBaseByGoodsId",@"act",[self goodsId],@"goodsId",nil];
    MKNetworkOperation *op = [YMGlobal getOperation:params];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"%@",[completedOperation responseString]);
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSMutableDictionary *object = [parser objectWithData:[completedOperation responseData]];
       if([(NSString *)[object objectForKey:@"errorMessage"]isEqualToString:@"success"])
       {                    
//这个是没有数组的
//           NSMutableDictionary *dataDic = [object objectForKey:@"data"];
//           self.goodsModel.goodsCode = [dataDic objectForKey:@"goodsCode"];
//           self.goodsModel.goodsMarketPrice = [dataDic objectForKey:@"goodsMarketPrice"];
//           self.goodsModel.goodsName = [dataDic objectForKey:@"goodsName"];
//           self.goodsModel.imageUrl = [dataDic objectForKey:@"imageUrl"];
//           self.goodsModel.property = [dataDic objectForKey:@"property"];
//           self.goodsModel.standard = [dataDic objectForKey:@"standard"];
//           self.goodsModel.store = [dataDic objectForKey:@"store"];
//           NSLog(@"%@",self.goodsModel.store);
//这个是有数组的
           NSMutableArray *dataArr = [object objectForKey:@"data"];
           NSMutableDictionary *dataDic = [dataArr objectAtIndex:0];
           self.goodsModel.goodsCode = [dataDic objectForKey:@"goodsCode"];
           self.goodsModel.goodsMarketPrice = [dataDic objectForKey:@"goodsMarketPrice"];
           self.goodsModel.goodsName = [dataDic objectForKey:@"goodsName"];
           self.goodsModel.imageUrl = [dataDic objectForKey:@"imageUrl"];
           self.goodsModel.property = [dataDic objectForKey:@"property"];
           self.goodsModel.standard = [dataDic objectForKey:@"standard"];
           self.goodsModel.store = [dataDic objectForKey:@"store"];
           NSLog(@"%@",self.goodsModel.store);
           [self.goodsTableView reloadData];
       }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"Error:%@",error);
    }];
    [hud hide:YES];
    [ApplicationDelegate.appEngine enqueueOperation:op];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(GoodsModel *)goodsModel
{
    if(_goodsModel == nil)
    {
        _goodsModel = [[GoodsModel alloc]init];
    }
    return _goodsModel;
}

- (void)viewDidUnload {
    [self setGoodsTableView:nil];
    [super viewDidUnload];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //第一格单元格高度
    if(indexPath.row == 0)
    {
        return 180;
    }
    //第二个单元格高度
    if(indexPath.row == 1)
    {
        return 465;
    }

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //当加载第一行时
    if(indexPath.row ==0)
    {
        static NSString *identifier = @"cellHeader";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        UIScrollView * imageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(30, 15, 260, 160)];
        imageScrollView.backgroundColor = [UIColor blueColor];
        imageScrollView.showsHorizontalScrollIndicator=YES;
        [cell.contentView addSubview:imageScrollView];
        return cell;
    }else if(indexPath.row ==1)
    {
        static NSString *identifier = @"cellMiddle";
          UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        //产品名字
        UILabel *nameLable = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 320, 43)];
        nameLable.text = @"2012秋装新款韩款女装中长版";
        [cell addSubview:nameLable];
        //产品价格
        UILabel *priceLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 32, 101, 30)];
        priceLable.textColor = [UIColor redColor];
        priceLable.text = @"￥567.00";
        priceLable.font = [UIFont systemFontOfSize:15.0];
        [cell addSubview:priceLable];
        //产品市场价
        UILabel *marketPriceLable = [[UILabel alloc]initWithFrame:CGRectMake(103, 32, 150, 30)];
        marketPriceLable.text = @"市场价:￥986.00";
        marketPriceLable.textColor = [UIColor grayColor];
        marketPriceLable.font = [UIFont systemFontOfSize:15.0];
        [cell addSubview:marketPriceLable];
        //产品尺码
        UILabel *chiMaLable = [[UILabel alloc]initWithFrame:CGRectMake(12, 70, 40, 25)];
        chiMaLable.text = @"尺码:";
        chiMaLable.font = [UIFont systemFontOfSize:15.0];
        [cell addSubview:chiMaLable];
        //生成尺寸的选择框按钮
        UIButton *chiBtn1 = [YMUIButton CreateSizeButton:@"20" CGFrame:CGRectMake(55, 70, 40, 26)];
        UIButton *chiBtn2 = [YMUIButton CreateSizeButton:@"30" CGFrame:CGRectMake(95, 70, 40, 26)];
        UIButton *chiBtn3 = [YMUIButton CreateSizeButton:@"40" CGFrame:CGRectMake(135, 70, 40, 26)];
        UIButton *chiBtn4 = [YMUIButton CreateSizeButton:@"50" CGFrame:CGRectMake(175, 70, 40, 26)];
        //设置点击大小按钮时候的事件
        [chiBtn1 addTarget:self action:@selector(chiMaCliked:)forControlEvents:UIControlEventTouchUpInside];
        [chiBtn2 addTarget:self action:@selector(chiMaCliked:)forControlEvents:UIControlEventTouchUpInside];
        [chiBtn3 addTarget:self action:@selector(chiMaCliked:)forControlEvents:UIControlEventTouchUpInside];
        [chiBtn4 addTarget:self action:@selector(chiMaCliked:)forControlEvents:UIControlEventTouchUpInside];
        //将这些按钮加入cell视图
        [cell addSubview:chiBtn1];
        [cell addSubview:chiBtn2];
        [cell addSubview:chiBtn3];
        [cell addSubview:chiBtn4];
        //颜色label
        UILabel *colorLable = [[UILabel alloc]initWithFrame:CGRectMake(12, 98, 50, 40)];
        [colorLable setText:@"颜色:"];
        [colorLable setFont:[UIFont systemFontOfSize:15.0]];
        [cell addSubview:colorLable];
        //生成颜色button  开始位置 60 112   大小 57＊20
        return cell;
    }else
    {
        static NSString *identifier = @"cellNon";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        return cell;

    }
}

//尺码按钮绑定的事件
-(void)chiMaCliked:(id)sender
{
    if(self.sizeBtn != nil)
    {
        [self.sizeBtn setBackgroundColor:[UIColor whiteColor]];
    }
    UIButton *PressedBtn = sender;
    self.sizeBtn = sender;
  
   
    [PressedBtn setBackgroundColor:[UIColor grayColor]];
    NSLog(@"%@",[sender titleLabel].text);
}

@end
