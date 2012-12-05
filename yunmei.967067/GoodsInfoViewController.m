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
           
           

           NSMutableDictionary *dataDic = [object objectForKey:@"data"];
           self.goodsModel.goodsCode = [dataDic objectForKey:@"goodsCode"];
           self.goodsModel.goodsMarketPrice = [dataDic objectForKey:@"goodsMarketPrice"];
           self.goodsModel.goodsName = [dataDic objectForKey:@"goodsName"];
           self.goodsModel.imageUrl = [dataDic objectForKey:@"imageUrl"];
           self.goodsModel.property = [dataDic objectForKey:@"property"];
           self.goodsModel.standard = [dataDic objectForKey:@"standard"];
           self.goodsModel.store = [dataDic objectForKey:@"store"];
           NSLog(@"%@",self.goodsModel.store);
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
    if(indexPath.row ==0)
    {
        static NSString *identifier = @"cellHeader";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        UIScrollView * imageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(35, 15, 250, 150)];
        imageScrollView.backgroundColor = [UIColor blueColor];
        imageScrollView.showsHorizontalScrollIndicator=YES;
        [cell.contentView addSubview:imageScrollView];
        
        return cell;
    }
    if(indexPath.row ==1)
    {
        static NSString *identifier = @"cellMiddle";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        UILabel *nameLable = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 320, 43)];
        nameLable.text = @"2012秋装新款韩款女装中长版";
        [cell addSubview:nameLable];
        UILabel *priceLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 32, 101, 30)];
        priceLable.textColor = [UIColor redColor];
        priceLable.text = @"￥567.00";
        [cell addSubview:priceLable];
        UILabel *marketPriceLable = [[UILabel alloc]initWithFrame:CGRectMake(103, 32, 150, 30)];
        marketPriceLable.text = @"市场价:￥986.00";
        marketPriceLable.textColor = [UIColor grayColor];
        [cell addSubview:marketPriceLable];
        UILabel *chiMaLable = [[UILabel alloc]initWithFrame:CGRectMake(12, 76, 50, 25)];
        chiMaLable.text = @"尺码:";
        chiMaLable.font = [UIFont systemFontOfSize:18.0];
        [cell addSubview:chiMaLable];
//        NSArray *chiMaArr = [NSArray arrayWithObjects:@"20",@"30",@"40",@"50",nil];
//        UISegmentedControl *chiMaChooce = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"20",@"30",@"40",@"50", nil]];
//        chiMaChooce.segmentedControlStyle = UISegmentedControlStyleBar;
//        chiMaChooce.tintColor = [UIColor whiteColor];
//        chiMaChooce.center = CGPointMake(137, 96);
//        chiMaChooce.frame = CGRectMake(70, 76, 160, 26);
//        UIB
//        [chiMaChooce ti
        UIButton *chiBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *chiBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *chiBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
        UIButton *chiBtn4 = [UIButton buttonWithType:UIButtonTypeCustom];
                             
        [chiBtn1 setFrame:CGRectMake(70, 76, 40, 26)];
        [chiBtn2 setFrame:CGRectMake(110, 76, 40, 26)];
        [chiBtn3 setFrame:CGRectMake(150, 76, 40, 26)];
        [chiBtn4 setFrame:CGRectMake(190, 76, 40, 26)];

        [chiBtn1 setTitle:@"20" forState:UIControlStateNormal];
        [chiBtn2 setTitle:@"30" forState:UIControlStateNormal];
        [chiBtn3 setTitle:@"40" forState:UIControlStateNormal];
        [chiBtn4 setTitle:@"50" forState:UIControlStateNormal];
//        [chiBtn1 addTarget:self action:@selector(buttonCliked)forControlEvents:UIControlEventTouchUpInside];
//        [chiBtn2 addTarget:self action:@selector(buttonCliked)forControlEvents:UIControlEventTouchUpInside];
//        [chiBtn3 addTarget:self action:@selector(buttonCliked)forControlEvents:UIControlEventTouchUpInside];
//        [chiBtn4 addTarget:self action:@selector(buttonCliked)forControlEvents:UIControlEventTouchUpInside];
        [chiBtn1 setBackgroundColor:[UIColor whiteColor]];
        [chiBtn2 setBackgroundColor:[UIColor whiteColor]];
        [chiBtn3 setBackgroundColor:[UIColor whiteColor]];
        [chiBtn4 setBackgroundColor:[UIColor whiteColor]];
        [chiBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [chiBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [chiBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [chiBtn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [chiBtn1 ]
        [cell addSubview:chiBtn1];
        [cell addSubview:chiBtn2];
        [cell addSubview:chiBtn3];
        [cell addSubview:chiBtn4];
        cell.textLabel.text = @"dsfsdfdf2";
        return cell;
    }

}

//-(void)buttonClicked:(id)sender
//{
//    NSLog(@"%@",[sender titleLabel]);
//}
@end
