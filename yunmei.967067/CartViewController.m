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
@synthesize controlInput;
@synthesize fistReTextFeild;
@synthesize payCount = _payCount;
//是否编辑或者取消编辑，YES为点击后开始编辑
bool cancleBuPressed = NO;
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

-(void)viewWillAppear:(BOOL)animated
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self bindCarWithGoodsList];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleBordered target:self action:@selector(carListEdit:)];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"结算" style:UIBarButtonItemStyleBordered target:self action:@selector(cartListPay:)];
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
    [self.view addSubview:self.goodsTableView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

-(UILabel *)payCount
{
    if(_payCount == nil)
    {
        //页脚价格总计
        _payCount = [[UILabel alloc]initWithFrame:CGRectMake(120, 288, 80, 15)];
        _payCount.text = [NSString stringWithFormat:@"￥%.2f",[self statisPay]];
        _payCount.font = [UIFont systemFontOfSize:12.0];
        _payCount.textColor= [UIColor redColor];
    }else{
        _payCount.text = [NSString stringWithFormat:@"￥%.2f",[self statisPay]];
    }
    return _payCount;
}
-(CGFloat)statisPay
{
    if([self.goodsList count]>0)
    {
        CGFloat i = 0.00;
        for(NSMutableDictionary *o in self.goodsList)
        {
            CGFloat multiPal = (CGFloat)([[o objectForKey:@"goods_count"] integerValue] *[[o objectForKey:@"goods_price"] integerValue]);
            i += multiPal;
        }
        return i;
    }else{
        return  0.00;
    }
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
    NSInteger height = [self.goodsList count]*100+100;
    [self.goodsTableView setFrame:CGRectMake(0, 0, 320, height)];
    
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

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *rootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 90)];
    UILabel *countString = [[UILabel alloc]initWithFrame:CGRectMake(90, 288, 30, 15)];
    countString.text = @"共计:";
    countString.font = [UIFont systemFontOfSize:12.0];
    countString.textColor= [UIColor grayColor];
    UIButton * carBuy = [[UIButton alloc]initWithFrame:CGRectMake(70, 50, 180, 35)];
    [carBuy setBackgroundImage:[UIImage imageNamed:@"CarBuy"] forState:UIControlStateNormal];
    [rootView addSubview:carBuy];
    [rootView addSubview:countString];
    [rootView addSubview:self.payCount];
    return rootView;


}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
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
        [cell.contentView addSubview:stringNum];
        [cell.contentView  addSubview:stringCode];
        [cell.contentView  addSubview:stringPrice];
        [cell.contentView  addSubview:cell.goodsCode];
        [cell.contentView  addSubview:cell.goodsName];
        [cell.contentView  addSubview:cell.goodsPrice];
        [cell.contentView  addSubview:cell.buyCount];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    NSString * ident = @"￥";
    cell.goodsCode.text = [[self.goodsList objectAtIndex:indexPath.row]objectForKey:@"goods_code"];
    cell.goodsName.text = [[self.goodsList objectAtIndex:indexPath.row]objectForKey:@"goods_name"];
    cell.goodsPrice.text = [ident stringByAppendingString:[[self.goodsList objectAtIndex:indexPath.row]objectForKey:@"goods_price"]];
    cell.buyCount.text = [[self.goodsList objectAtIndex:indexPath.row]objectForKey:@"goods_count"];
    cell.buyCount.layer.cornerRadius = 0.8;
    cell.buyCount.tag = indexPath.row;
    cell.buyCount.delegate = self;
    if(self.textFieldList.count < self.goodsList.count)
    {
        if(tableView.editing)
        {
            cell.buyCount.enabled = YES;
            [cell.buyCount setBorderStyle:UITextBorderStyleRoundedRect];
        }
        [self.textFieldList addObject:cell.buyCount];
    }
    NSLog(@"%i",[self.textFieldList count]);
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     if(self.goodsList.count >0)
     {
         
         NSMutableDictionary *goods = [self.goodsList objectAtIndex:indexPath.row];
         NSString *goodsId = [goods objectForKey:@"goodsid"];
         GoodsInfoViewController *goodsInfo = [[GoodsInfoViewController alloc]init];
         goodsInfo.goodsId = goodsId;
         if([[goods objectForKey:@"proid"] integerValue] == 0)
         {
             goodsInfo.carBackToInfo = nil;
         }else{
             [goodsInfo.carBackToInfo setObject:[goods objectForKey:@"goods_price"] forKey:@"pro_price"];
             [goodsInfo.carBackToInfo setObject:[goods objectForKey:@"goods_store"] forKey:@"pro_store"];
             [goodsInfo.carBackToInfo setObject:[goods objectForKey:@"proid"] forKey:@"pro_id"];
         }
         goodsInfo.firstResponderTextFeild.text =[goods objectForKey:@"goods_count"];
         UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
         self.navigationItem.backBarButtonItem = backItem;
         [self.navigationController pushViewController:goodsInfo animated:YES];
     }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSUInteger row = indexPath.row;
        NSMutableDictionary *deleteObject = [self.goodsList objectAtIndex:row];
        YMDbClass *db = [[YMDbClass alloc]init];
        if([db connect])
        {
            NSString *query = [NSString stringWithFormat:@"DELETE FROM goodslist_car WHERE goodsId = '%@' AND proid = '%@';",[deleteObject objectForKey:@"goodsid"],[deleteObject objectForKey:@"proid"]];
            if([db exec:query])
            {
                [[self.tabBarController.tabBar.items objectAtIndex:2] setBadgeValue:[db count_sum:@"goodslist_car" tablefiled:@"goods_count"]];
            }
            [self bindCarWithGoodsList];
            [self.payCount reloadInputViews];
            [self.view reloadInputViews];
        }
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.textFieldList removeAllObjects];
        [tableView reloadData];
    }
}
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//点击编辑的时候
-(void)carListEdit:(id)sender
{
    [self.goodsTableView setEditing:!self.goodsTableView.editing animated:YES];
    if (self.goodsTableView.editing)
    { 
        for(UITextField *o in self.textFieldList)
        {
            [o setBorderStyle:UITextBorderStyleRoundedRect];
            [o setEnabled:YES];
        }
        self.navigationItem.leftBarButtonItem.title = @"取消";
        self.navigationItem.rightBarButtonItem.title = @"完成";

    }else{
            cancleBuPressed = YES;
        for(UITextField *o in self.textFieldList)
        {
            [o setBorderStyle:UITextBorderStyleNone];
            [o setEnabled:NO];
        }
        [self.goodsTableView reloadData];
        self.navigationItem.leftBarButtonItem.title = @"编辑";
        self.navigationItem.rightBarButtonItem.title = @"结算";
    }
}

//点击结算的时候
-(void)cartListPay:(id)sender
{
    if(self.goodsTableView.editing == NO)
    {
        NSLog(@"结算");
    }else{
        [self.goodsTableView setEditing:!self.goodsTableView.editing animated:YES];
        for(UITextField *o in self.textFieldList)
        {
            [o setBorderStyle:UITextBorderStyleNone];
            [o setEnabled:NO];
            [o resignFirstResponder];
        }
        self.navigationItem.leftBarButtonItem.title = @"编辑";
        self.navigationItem.rightBarButtonItem.title = @"结算";
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.view.superview addSubview:self.controlInput];
    self.fistReTextFeild = textField;
}
//完成编辑的时候，更新数据库内容和程序数组中存储的内容
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSInteger i;
    if([textField.text isEqualToString:@"0"])
    {
        i =1;
    }else{
        i = textField.text.integerValue;
    }
    NSMutableDictionary *goodsInSqlite = [self.goodsList objectAtIndex:textField.tag];
    if((![textField.text isEqualToString:[goodsInSqlite objectForKey:@"goods_count"]])&&(cancleBuPressed == NO))
    {
        NSLog(@"不等");
        if(textField.text.integerValue >[[goodsInSqlite objectForKey:@"goods_store"] integerValue])
        {
            i = [[goodsInSqlite objectForKey:@"goods_store"] integerValue];
        }

        NSString * goodsId = [goodsInSqlite objectForKey:@"goodsid"];
        NSString *proid = [goodsInSqlite objectForKey:@"proid"];
        YMDbClass *db = [[YMDbClass alloc]init];
        if([db connect])
        {
            NSString *query = [NSString stringWithFormat:@"UPDATE goodslist_car SET goods_count = '%i' WHERE goodsId = '%@' AND proid = '%@';",i,goodsId,proid];
            [db exec:query];
        }
        [self bindCarWithGoodsList];
        [self.payCount reloadInputViews];
        [[self.tabBarController.tabBar.items objectAtIndex:2] setBadgeValue:[db count_sum:@"goodslist_car" tablefiled:@"goods_count"]];
        [self.goodsTableView reloadData];
        
    }else if (cancleBuPressed ==YES){
        NSLog(@"相等");
        cancleBuPressed = NO;
        [self.goodsTableView reloadData];
    }
}

-(void)setDataSource
{
    [self bindCarWithGoodsList];
    if(self.goodsList.count >self.textFieldList.count)
    {
        [self.textFieldList removeAllObjects];
        [self.goodsTableView reloadData];
    }
    [self.payCount reloadInputViews];
    [self.goodsTableView reloadData];
    
}

@end
