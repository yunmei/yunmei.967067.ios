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
@synthesize deleteBtnArr = _deleteBtnArr;
@synthesize controlInput;
@synthesize fistReTextFeild;
@synthesize indexArr = _indexArr;
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
-(NSMutableArray *)deleteBtnArr
{
    if(_deleteBtnArr == nil)
    {
        _deleteBtnArr = [[NSMutableArray alloc]init];
    }
    return _deleteBtnArr;
}
-(NSMutableArray *)indexArr
{
    if(_indexArr == nil)
    {
        _indexArr = [[NSMutableArray alloc]init];
    }
    return _indexArr;
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
        cell.buyCount.tag = indexPath.row;
        cell.buyCount.delegate = self;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self.textFieldList addObject:cell.buyCount];
        //添加删除按钮
        UIButton * deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(250, 40, 50, 26)];
        [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [deleteBtn setBackgroundColor:[UIColor colorWithRed:230/255.0 green:115/255.0 blue:0 alpha:1.0]];
        [deleteBtn.layer setCornerRadius:3.0];
        deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        deleteBtn.titleLabel.textColor = [UIColor whiteColor];
        deleteBtn.tag = indexPath.row;
        [deleteBtn addTarget:self action:@selector(deleteCell:) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.hidden = YES;
        [self.deleteBtnArr addObject:deleteBtn];
        [cell addSubview:deleteBtn];
        [self.indexArr addObject:indexPath];
    }
    NSString * ident = @"￥";
    cell.goodsCode.text = [[self.goodsList objectAtIndex:indexPath.row]objectForKey:@"goods_code"];
    cell.goodsName.text = [[self.goodsList objectAtIndex:indexPath.row]objectForKey:@"goods_name"];
    cell.goodsPrice.text = [ident stringByAppendingString:[[self.goodsList objectAtIndex:indexPath.row]objectForKey:@"goods_price"]];
    cell.buyCount.text = [[self.goodsList objectAtIndex:indexPath.row]objectForKey:@"goods_count"];
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
//点击编辑的时候
-(void)carListEdit:(id)sender
{
    if (canBeEdited ==YES)
    {
        for(UITextField *o in self.textFieldList)
        {
            [o setBorderStyle:UITextBorderStyleLine];
            [o setEnabled:YES];
        }
        for(UIButton * k in self.deleteBtnArr)
        {
            [k setHidden:NO];
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
        for(UIButton * k in self.deleteBtnArr)
        {
            [k setHidden:YES];
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

//绑定删除按钮事件
-(void)deleteCell:(id)sender
{
    [sender setBackgroundColor:[UIColor colorWithRed:210/255.0 green:120/255.0 blue:70/255.0 alpha:1.0]];
    UIButton *del = sender;
//    NSIndexPath *indexPath = [self.goodsTableView indexPathForSelectedRow];
//    NSLog(@"%i",indexPath.row);
//    [self.goodsTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[self.indexArr objectAtIndex:del.tag]]withRowAnimation:UITableViewRowAnimationFade];
//    [self.goodsTableView reloadData];
}
@end
