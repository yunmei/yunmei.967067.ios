//
//  CartViewController.m
//  yunmei.967067
//
//  Created by bevin chen on 12-11-7.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "CartViewController.h"
#import "YMUIButton.h"
@interface CartViewController ()

@end

@implementation CartViewController
@synthesize goodsList = _goodsList;
@synthesize goodsTableView = _goodsTableView;
@synthesize textFieldList = _textFieldList;
@synthesize controlInput;
@synthesize fistReTextFeild;
@synthesize payCount = _payCount;
@synthesize payCountAnother = _payCountAnother;
bool emptyCar = NO;
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
        _payCount = [[UILabel alloc]initWithFrame:CGRectMake(150, 30, 70, 15)];
        _payCount.text = [NSString stringWithFormat:@"￥%.2f",[self statisPay]];
        _payCount.font = [UIFont systemFontOfSize:12.0];
        _payCount.textColor= [UIColor redColor];
    }else{
        _payCount.text = [NSString stringWithFormat:@"￥%.2f",[self statisPay]];
    }
    return _payCount;
}

-(UILabel *)payCountAnother
{
    if(_payCountAnother == nil)
    {
        //页脚价格总计
        _payCountAnother = [[UILabel alloc]initWithFrame:CGRectMake(120, 12, 70, 15)];
        _payCountAnother.text = [NSString stringWithFormat:@"￥%.2f",[self statisPay]];
        _payCountAnother.font = [UIFont systemFontOfSize:12.0];
        _payCountAnother.textColor= [UIColor redColor];
    }else{
        _payCountAnother.text = [NSString stringWithFormat:@"￥%.2f",[self statisPay]];
    }
    return _payCountAnother;
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
    [self.goodsTableView setFrame:CGRectMake(0, 0, 320, 363)];
    if(self.goodsList.count >0)
    {
        emptyCar = NO;
        UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleBordered target:self action:@selector(carListEdit:)];
        UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"结算" style:UIBarButtonItemStyleBordered target:self action:@selector(cartListPay:)];
        self.navigationItem.leftBarButtonItem = leftBtn;
        self.navigationItem.rightBarButtonItem = rightBtn;
        self.navigationItem.leftBarButtonItem.enabled =YES;
        self.navigationItem.rightBarButtonItem.enabled = YES;
        self.goodsTableView.scrollEnabled = YES;
    }else{
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = nil;
        emptyCar =YES;
    }
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(emptyCar == NO)
    {
        return  100;
    }else{
        return  290;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(emptyCar == NO)
    {
        return self.goodsList.count+1;
    }else{
        return 1;
    }
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(emptyCar == NO)
    {
        {
            if(indexPath.row == self.goodsList.count)
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"footer"];
                if(cell == nil)
                {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"footer"];
                    UILabel *yuanshiString = [[UILabel alloc]initWithFrame:CGRectMake(60, 12, 57, 15)];
                    yuanshiString.text = @"原始金额:";
                    yuanshiString.font = [UIFont systemFontOfSize:12.0];
                    yuanshiString.textColor= [UIColor grayColor];
                    
                    UILabel *fanxian = [[UILabel alloc]initWithFrame:CGRectMake(187, 12, 100, 15)];
                    fanxian.text = @"- 返现金额:￥0.00";
                    fanxian.font = [UIFont systemFontOfSize:12.0];
                    fanxian.textColor= [UIColor grayColor];
                    
                    UILabel *countString = [[UILabel alloc]initWithFrame:CGRectMake(120, 30, 30, 15)];
                    countString.text = @"共计:";
                    countString.font = [UIFont systemFontOfSize:12.0];
                    countString.textColor= [UIColor grayColor];
                    UIButton * carBuy = [[UIButton alloc]initWithFrame:CGRectMake(70, 50, 180, 35)];
                    [carBuy setBackgroundImage:[UIImage imageNamed:@"CarBuy"] forState:UIControlStateNormal];
                    [cell addSubview:carBuy];
                    [cell addSubview:countString];
                    [cell addSubview:self.payCount];
                    [cell addSubview:self.payCountAnother];
                    [cell  addSubview:yuanshiString];
                    [cell addSubview:fanxian];
                }
                return cell;
            }else{
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
                    stringNum.backgroundColor = [UIColor clearColor];
                    stringCode.backgroundColor = [UIColor clearColor];
                    stringNum.backgroundColor = [UIColor clearColor];
                    stringPrice.backgroundColor = [UIColor clearColor];
                    cell.goodsCode.backgroundColor = [UIColor clearColor];
                    cell.goodsName.backgroundColor = [UIColor clearColor];
                    cell.goodsPrice.backgroundColor = [UIColor clearColor];
                    cell.buyCount.backgroundColor = [UIColor clearColor];
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
        }
    }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"image"];
            if(cell == nil)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"image"];
                UIView *container = [[UIView alloc]initWithFrame:CGRectMake(20, 20, 280, 200)];
                [container.layer setCornerRadius:8.0];
                [container.layer setBorderWidth:1.0];
                [container.layer setBorderColor:[YMUIButton CreateCGColorRef:186 greenNumber:186 blueNumber:186 alphaNumber:1.0]];
                UIImageView * centerPic = [[UIImageView alloc]initWithFrame:CGRectMake(97, 60, 85, 80)];
                [centerPic setImage:[UIImage imageNamed:@"empty_cart_bg.png"]];
                UILabel *emptyString = [[UILabel alloc]initWithFrame:CGRectMake(50, 160, 200, 15)];
                [emptyString setText:@"购物车里是空的，快去选购吧！"];
                [emptyString setFont:[UIFont systemFontOfSize:12.0]];
                [emptyString setTextColor:[UIColor grayColor]];
                [container addSubview:centerPic];
                [container addSubview:emptyString];
                //去逛逛
                //去逛逛
                UIButton * goToSee = [UIButton buttonWithType:UIButtonTypeCustom];
                [goToSee setFrame:CGRectMake(100, 250, 110, 30)];
                [goToSee setTitle:@"去逛逛" forState:UIControlStateNormal];
                [goToSee setBackgroundImage:[UIImage imageNamed:@"btn_yellow"] forState:UIControlStateNormal];
                [goToSee setBackgroundColor:[UIColor redColor]];
                [cell addSubview:container];
                [cell  addSubview:goToSee];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [tableView setScrollEnabled:NO];
            [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
            return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row!=self.goodsList.count)
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
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row != self.goodsList.count)
    {
        UIColor *color = ((indexPath.row %2) == 0)?[UIColor colorWithRed:255/255.0 green:228/255.0 blue:196/255.0 alpha:1.0]:[UIColor clearColor];
        cell.backgroundColor = color;
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == self.goodsList.count)
    {
        return  NO;
    }else{
        return YES;
    }

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
            if(self.goodsList.count >0)
            {
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }else{
                [self.goodsTableView reloadData];
            }
            [self.payCount reloadInputViews];
            [self.payCountAnother reloadInputViews];
            [self.view reloadInputViews];
        }
        [self.textFieldList removeAllObjects];
        
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
        [self.payCountAnother reloadInputViews];
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
    [self.payCountAnother reloadInputViews];
    [self.goodsTableView reloadData];
    
}

@end
