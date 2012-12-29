//
//  CartViewController.m
//  yunmei.967067
//
//  Created by bevin chen on 12-11-7.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "CartViewController.h"

@interface CartViewController ()

@end

@implementation CartViewController
@synthesize goodsList = _goodsList;
@synthesize goodsTableView = _goodsTableView;
@synthesize textFieldList = _textFieldList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"购物车", @"购物车");
        self.navigationItem.title = @"购物车";
        [self.tabBarItem setImage:[UIImage imageNamed:@"tabbar_cart"]];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
            [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_cart"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_cart_unselected"]];
        }
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self bindCarWithGoodsList];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleBordered target:self action:@selector(carListEdit)];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"结算" style:UIBarButtonItemStyleBordered target:self action:@selector(cartListPay)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.navigationItem.rightBarButtonItem = rightBtn;
    if(self.goodsList.count > 0)
    {
        self.navigationItem.leftBarButtonItem.enabled =YES;
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }else{
        self.navigationItem.leftBarButtonItem.enabled = NO;
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

//

//绑定购物车
-(void)bindCarWithGoodsList
{
    YMDbClass *db = [[YMDbClass alloc]init];
    if([db connect])
    {
        NSString *query = [NSString stringWithFormat:@"SELECT goodsid ,goods_code,goods_name,goods_price,goods_store,proid,goods_count FROM goodslist_car;"];
        self.goodsList = [db fetchAll:query];
        [db close];
    }
    CGFloat height = [self.goodsList count]*100 +80;
    [self.goodsTableView setFrame:CGRectMake(0, 0, 320, height)];
    [self.view addSubview:self.goodsTableView];
    //NSLog(@"%@",self.goodsList);
    
}

-(UITableView *)goodsTableView
{
    if(_goodsTableView == nil)
    {
        _goodsTableView = [[UITableView alloc]init];
    }
    _goodsTableView.dataSource = self;
    _goodsTableView.delegate = self;
    return _goodsTableView;
}
-(NSMutableArray *)goodsList
{
    if(_goodsList == nil)
    {
        _goodsList = [[NSMutableArray alloc]init];
    }
    return _goodsList;
}
-(NSMutableArray *)textFieldList
{
    if(_textFieldList == nil)
    {
        _textFieldList = [[NSMutableArray alloc]init];
    }
    return _textFieldList;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  100;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goodsList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellForCar";
    CarCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil)
    {
        cell = [[CarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        UILabel *stringCode = [[UILabel alloc]initWithFrame:CGRectMake(10, 36, 60, 30)];
        [stringCode setText:@"商品编码:"];
        [stringCode setTextColor:[UIColor grayColor]];
        [stringCode setFont:[UIFont systemFontOfSize:13.0]];
        UILabel *stringNum = [[UILabel alloc]initWithFrame:CGRectMake(150, 65, 60, 30)];
        [stringNum setText:@"数量:"];
        [stringNum setTextColor:[UIColor grayColor]];
        [stringNum setFont:[UIFont systemFontOfSize:13.0]];
        UILabel *stringPrice = [[UILabel alloc]initWithFrame:CGRectMake(10, 65, 60, 30)];
        [stringPrice setText:@"价格:"];
        [stringPrice setTextColor:[UIColor grayColor]];
        [stringPrice setFont:[UIFont systemFontOfSize:13.0]];
        [cell addSubview:stringNum];
        [cell addSubview:stringCode];
        [cell addSubview:stringPrice];
        [cell addSubview:cell.goodsCode];
        [cell addSubview:cell.goodsName];
        [cell addSubview:cell.goodsPrice];
        [cell addSubview:cell.buyCount];
    }
    NSString * ident = @"￥";
    cell.goodsCode.text = [[self.goodsList objectAtIndex:indexPath.row]objectForKey:@"goods_code"];
    cell.goodsName.text = [[self.goodsList objectAtIndex:indexPath.row]objectForKey:@"goods_name"];
    cell.goodsPrice.text = [ident stringByAppendingString:[[self.goodsList objectAtIndex:indexPath.row]objectForKey:@"goods_price"]];
    cell.buyCount.text = [[self.goodsList objectAtIndex:indexPath.row]objectForKey:@"goods_count"];
    NSLog(@"%@",[[self.goodsList objectAtIndex:indexPath.row]objectForKey:@"goods_count"]);
        
    return cell;
}
@end
