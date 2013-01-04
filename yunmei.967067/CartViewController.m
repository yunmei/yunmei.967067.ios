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
//是否编辑或者取消编辑，YES为点击后开始编辑
bool canBeEdited = YES;
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
    [self bindCarWithGoodsList];
    [self.goodsTableView reloadData];			
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
     UIButton * carBuy = [[UIButton alloc]initWithFrame:CGRectMake(70, 310, 180, 35)];
    [carBuy setBackgroundImage:[UIImage imageNamed:@"CarBuy"] forState:UIControlStateNormal];
    [self.view addSubview:carBuy];
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
    [self.goodsTableView setFrame:CGRectMake(0, 0, 320, 280)];
    [self.view addSubview:self.goodsTableView];
    NSLog(@"%@",self.goodsList);
    
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
        [cell.contentView addSubview:stringNum];
        [cell.contentView  addSubview:stringCode];
        [cell.contentView  addSubview:stringPrice];
        [cell.contentView  addSubview:cell.goodsCode];
        [cell.contentView  addSubview:cell.goodsName];
        [cell.contentView  addSubview:cell.goodsPrice];
        [cell.contentView  addSubview:cell.buyCount];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];      
    }
    NSString * ident = @"￥";
    cell.goodsCode.text = [[self.goodsList objectAtIndex:indexPath.row]objectForKey:@"goods_code"];
    cell.goodsName.text = [[self.goodsList objectAtIndex:indexPath.row]objectForKey:@"goods_name"];
    cell.goodsPrice.text = [ident stringByAppendingString:[[self.goodsList objectAtIndex:indexPath.row]objectForKey:@"goods_price"]];
    cell.buyCount.text = [[self.goodsList objectAtIndex:indexPath.row]objectForKey:@"goods_count"];
    cell.buyCount.layer.cornerRadius = 0.8;
    cell.buyCount.tag = indexPath.row;
    cell.buyCount.delegate = self;
    [self.textFieldList addObject:cell.buyCount];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.fistReTextFeild resignFirstResponder];
    for(UITextField *o in self.textFieldList)
    {
        [o setBorderStyle:UITextBorderStyleNone];
        [o setEnabled:NO];
    }
    canBeEdited = YES;
    self.navigationItem.leftBarButtonItem.title = @"编辑";
    self.navigationItem.rightBarButtonItem.title = @"结算";
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
        }
        [self.goodsList removeObjectAtIndex:row];
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
    if (canBeEdited ==YES)
    {
        for(UITextField *o in self.textFieldList)
        {
            [o setBorderStyle:UITextBorderStyleRoundedRect];
            [o setEnabled:YES];
        }
        self.navigationItem.leftBarButtonItem.title = @"取消";
        self.navigationItem.rightBarButtonItem.title = @"完成";
        canBeEdited = NO;
    }else{
            cancleBuPressed = YES;
        for(UITextField *o in self.textFieldList)
        {
            [o setBorderStyle:UITextBorderStyleNone];
            [o setEnabled:NO];
        }
        [self.goodsTableView reloadData];
         canBeEdited = YES;
        self.navigationItem.leftBarButtonItem.title = @"编辑";
        self.navigationItem.rightBarButtonItem.title = @"结算";
    }
}

//点击结算的时候
-(void)cartListPay:(id)sender
{
    if(canBeEdited == YES)
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
        canBeEdited = YES;
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
    if(textField.text.integerValue == 0)
    {
        i =1;
    }else{
        i = textField.text.integerValue;
    }
    NSMutableDictionary *goodsInSqlite = [self.goodsList objectAtIndex:textField.tag];
    if((textField.text != [goodsInSqlite objectForKey:@"goods_count"])&&(cancleBuPressed == NO))
    {
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
        [[self.tabBarController.tabBar.items objectAtIndex:2] setBadgeValue:[db count_sum:@"goodslist_car" tablefiled:@"goods_count"]];
        [self.goodsTableView reloadData];
        
    }else if (cancleBuPressed ==YES){
        cancleBuPressed = NO;
        [self.goodsTableView reloadData];
    }
}

@end
