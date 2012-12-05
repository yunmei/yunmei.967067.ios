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
@synthesize tableView;
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
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSMutableDictionary *object = [parser objectWithData:[completedOperation responseData]];
       if([(NSString *)[object objectForKey:@"errorMessage"]isEqualToString:@"success"])
       {
//           
//           
//
//           NSMutableDictionary *dataDic = [object objectForKey:@"data"];
//           self.goodsModel.goodsCode = [dataDic objectForKey:@"goodsCode"];
//           self.goodsModel.goodsMarketPrice = [dataDic objectForKey:@"goodsMarketPrice"];
//           self.goodsModel.goodsName = [dataDic objectForKey:@"goodsName"];
//           self.goodsModel.imageUrl = [dataDic objectForKey:@"imageUrl"];
//           self.goodsModel.property = [dataDic objectForKey:@"property"];
//           self.goodsModel.standard = [dataDic objectForKey:@"standard"];
//           self.goodsModel.store = [dataDic objectForKey:@"store"];
//           NSLog(@"%@",self.goodsModel.store);
           [self.tableView reloadData];
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
    [self setTableView:nil];
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
    }
    //加载第二行时
    if(indexPath.row ==1)
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
        [cell addSubview:priceLable];
        //产品市场价
        UILabel *marketPriceLable = [[UILabel alloc]initWithFrame:CGRectMake(103, 32, 150, 30)];
        marketPriceLable.text = @"市场价:￥986.00";
        marketPriceLable.textColor = [UIColor grayColor];
        [cell addSubview:marketPriceLable];
        //产品尺码
        UILabel *chiMaLable = [[UILabel alloc]initWithFrame:CGRectMake(12, 76, 50, 25)];
        chiMaLable.text = @"尺码:";
        chiMaLable.font = [UIFont systemFontOfSize:18.0];
        [cell addSubview:chiMaLable];
        //生成尺寸的选择框按钮
        UIButton *chiBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *chiBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *chiBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *chiBtn4 = [UIButton buttonWithType:UIButtonTypeCustom];
        //按钮定位
        [chiBtn1 setFrame:CGRectMake(70, 76, 40, 26)];
        [chiBtn2 setFrame:CGRectMake(110, 76, 40, 26)];
        [chiBtn3 setFrame:CGRectMake(150, 76, 40, 26)];
        [chiBtn4 setFrame:CGRectMake(190, 76, 40, 26)];
        //设置标题
        [chiBtn1 setTitle:@"20" forState:UIControlStateNormal];
        [chiBtn2 setTitle:@"30" forState:UIControlStateNormal];
        [chiBtn3 setTitle:@"40" forState:UIControlStateNormal];
        [chiBtn4 setTitle:@"50" forState:UIControlStateNormal];
        //设置点击大小按钮时候的事件
        [chiBtn1 addTarget:self action:@selector(chiMaCliked:)forControlEvents:UIControlEventTouchUpInside];
        [chiBtn2 addTarget:self action:@selector(chiMaCliked:)forControlEvents:UIControlEventTouchUpInside];
        [chiBtn3 addTarget:self action:@selector(chiMaCliked:)forControlEvents:UIControlEventTouchUpInside];
        [chiBtn4 addTarget:self action:@selector(chiMaCliked:)forControlEvents:UIControlEventTouchUpInside];
        //设置背景色
        [chiBtn1 setBackgroundColor:[UIColor whiteColor]];
        [chiBtn2 setBackgroundColor:[UIColor whiteColor]];
        [chiBtn3 setBackgroundColor:[UIColor whiteColor]];
        [chiBtn4 setBackgroundColor:[UIColor whiteColor]];
        //设置字体颜色
        [chiBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [chiBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [chiBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [chiBtn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //设置边框宽
        [chiBtn1.layer setBorderWidth:1.0];
        [chiBtn2.layer setBorderWidth:1.0];
        [chiBtn3.layer setBorderWidth:1.0];
        [chiBtn4.layer setBorderWidth:1.0];
        //生成button边框的颜色
        CGFloat r = (CGFloat)228/255.0;
        CGFloat g = (CGFloat)228/255.0;
        CGFloat b = (CGFloat)228/55.0;
        CGFloat a = (CGFloat) 1.0;
        CGFloat componets[4] = {r,g,b,a};
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef borderColor = CGColorCreate(colorSpace, componets);
        [chiBtn1.layer setBorderColor:borderColor];
        [chiBtn2.layer setBorderColor:borderColor];
        [chiBtn3.layer setBorderColor:borderColor];
        [chiBtn4.layer setBorderColor:borderColor];
        //生成button被按下时候的背景色
//        CGFloat r1 = (CGFloat)237/255.0;
//        CGFloat g1 = (CGFloat)237/255.0;
//        CGFloat b1 = (CGFloat)237/55.0;
//        CGFloat a1 = (CGFloat) 1.0;
//        CGFloat componets1[4] = {r1,g1,b1,a1};
//        CGColorSpaceRef colorSpace1 = CGColorSpaceCreateDeviceRGB();
//        CGColorRef backgroundColor = CGColorCreate(colorSpace1, componets1);
//        UIColor *backColor = [UIColor colorWithCGColor:backgroundColor];
        //将这些按钮加入cell视图
        [cell addSubview:chiBtn1];
        [cell addSubview:chiBtn2];
        [cell addSubview:chiBtn3];
        [cell addSubview:chiBtn4];
        return cell;
    }

}


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
