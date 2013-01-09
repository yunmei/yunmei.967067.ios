//
//  OrderEditViewController.m
//  yunmei.967067
//
//  Created by ken on 13-1-8.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import "OrderEditViewController.h"

@interface OrderEditViewController ()

@end

@implementation OrderEditViewController
@synthesize orderTableView;
@synthesize goodsInfoList= _goodsInfoList;
bool payAfterCustomerGetGoods = YES;
@synthesize checkRadioArray = _checkRadioArray;
@synthesize orderRemarkFeild;
@synthesize tapGestureRecgnizer = _tapGestureRecgnizer;
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
    self.navigationItem.title = @"齐鲁直销商城";
    [self bindCar];
}

-(void)bindCar
{
    YMDbClass *db = [[YMDbClass alloc]init];
    if([db connect])
    {
        NSString *query = [NSString stringWithFormat:@"SELECT goodsid ,goods_code,goods_name,goods_price,goods_store,proid,goods_count FROM goodslist_car;"];
        self.goodsInfoList = [db fetchAll:query];
        [db close];
        NSLog(@"%@",self.goodsInfoList);
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row ==1)
    {
        return 30+72*self.goodsInfoList.count;
    }else if (indexPath.row == 0){
        return 50.0;
    }else if (indexPath.row == 5){
        return 80.0;
    }else{
        return 50.0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 1)
    {
        static NSString *identifier = @"info";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            UILabel *infoString = [[UILabel alloc]initWithFrame:CGRectMake(3, 5, 80, 30)];
            infoString.text = @"商品信息";
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell addSubview:infoString];
            NSLog(@"cell xian");
        }
            CGFloat currentViewHeightInit =25;
            for(NSMutableDictionary *o in self.goodsInfoList)
            {
                goodsInfoView *goodsSubView = [[goodsInfoView alloc]init];
                goodsSubView.goodsName.text = [o objectForKey:@"goods_name"];
                goodsSubView.goodsCount.text = [o objectForKey:@"goods_count"];
                NSString * formatPrice = [NSString stringWithFormat:@"%.2f",(float)[[o objectForKey:@"goods_count"] integerValue] *[[o objectForKey:@"goods_price"]floatValue]];
                goodsSubView.codeNumber.text = [o objectForKey:@"goods_code"];
                NSString *moneyType = @"￥";
                goodsSubView.totalPrice.text = [moneyType stringByAppendingString:formatPrice];
                [goodsSubView addChild];
                NSLog(@"%f",goodsSubView.height);
                [goodsSubView setFrame:CGRectMake(3, currentViewHeightInit, 320, 72)];
                [cell addSubview:goodsSubView];
                currentViewHeightInit += 72;
                [cell.superview addSubview:goodsSubView];
            }
            
        return cell;
    }else if (indexPath.row ==0){
        static NSString *identifier = @"identifier0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            UILabel *writeInAddress = [[UILabel alloc]initWithFrame:CGRectMake(3, 3, 80, 20)];
            writeInAddress.text = @"售货信息";
            writeInAddress.font = [UIFont systemFontOfSize:14.0];
            [cell addSubview:writeInAddress];
            UILabel *pleaseWriteInAddress = [[UILabel alloc]initWithFrame:CGRectMake(3, 25, 100, 20)];
            pleaseWriteInAddress.text = @"请填写收货地址";
            pleaseWriteInAddress.font = [UIFont systemFontOfSize:12.0];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell addSubview:pleaseWriteInAddress];
        }
        return cell;
    }else if(indexPath.row ==2){
        static NSString *identifier = @"identifier2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            UILabel *payMethod = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, 70, 25)];
            payMethod.text = @"支付方式:";
            payMethod.font = [UIFont systemFontOfSize:14.0];
            UIButton *payAfterGetGoodsBtn = [[UIButton alloc]initWithFrame:CGRectMake(90, 12, 25, 25)];
            [payAfterGetGoodsBtn setBackgroundImage:[UIImage imageNamed:@"RadioButton-Selected"] forState:UIControlStateNormal];
            [payAfterGetGoodsBtn addTarget:self action:@selector(payAfterGetGoodsPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self.checkRadioArray addObject:payAfterGetGoodsBtn];
            UILabel *payAfterGetGoodsString = [[UILabel alloc]initWithFrame:CGRectMake(120, 12, 70, 25)];
            payAfterGetGoodsString.text = @"货到付款";
            payAfterGetGoodsString.font = [UIFont systemFontOfSize:14.0];
            UIButton *payOlineBtn = [[UIButton alloc]initWithFrame:CGRectMake(190, 12, 25, 25)];
            [payOlineBtn setBackgroundImage:[UIImage imageNamed:@"RadioButton-Unselected"] forState:UIControlStateNormal];
            [payOlineBtn addTarget:self action:@selector(payOnlinePressed:) forControlEvents:UIControlEventTouchUpInside];
            [self.checkRadioArray addObject:payOlineBtn];
            UILabel *payOnlineString = [[UILabel alloc]initWithFrame:CGRectMake(220, 12, 60, 25)];
            payOnlineString.text = @"在线支付";
            payOnlineString.font = [UIFont systemFontOfSize:14.0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell addSubview:payOnlineString];
            [cell addSubview:payMethod];
            [cell addSubview:payOlineBtn];
            [cell addSubview:payAfterGetGoodsBtn];
            [cell addSubview:payAfterGetGoodsString];
        }
        return cell;
    }else if (indexPath.row == 3){
        static NSString *identifier = @"identifier3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            UILabel *payMethodString = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 70, 20)];
            payMethodString.text = @"配送方式:";
            payMethodString.font = [UIFont systemFontOfSize:14.0];
            UILabel *payAction = [[UILabel alloc]initWithFrame:CGRectMake(90, 15, 200, 20)];
            payAction.text = @"配送齐鲁直销商城配送";
            payAction.font = [UIFont systemFontOfSize:12.0];
            [cell addSubview:payMethodString];
            [cell addSubview:payAction];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        return cell;
    }else if (indexPath.row ==4){
        static NSString *identifier = @"identifier4";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            UILabel *orderRemark = [[UILabel alloc]initWithFrame:CGRectMake(10, 14, 60, 20)];
            orderRemark.text = @"订单备注:";
            orderRemark.font = [UIFont systemFontOfSize:14.0];
            self.orderRemarkFeild = [[UITextField alloc]initWithFrame:CGRectMake(80, 12, 200, 27)];
            self.orderRemarkFeild.delegate = self;
            [self.orderRemarkFeild setBorderStyle:UITextBorderStyleRoundedRect];
            [cell addSubview:orderRemark];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell addSubview:orderRemarkFeild];
        }
        return cell;
    }else{
        static NSString *identifier = @"identifier5";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            UILabel *totalPayCountString = [[UILabel alloc]initWithFrame:CGRectMake(160, 10, 50, 30)];
            totalPayCountString.text = @"总金额:";
            totalPayCountString.font = [UIFont systemFontOfSize:15.0];
            UILabel *totalPayCount = [[UILabel alloc]initWithFrame:CGRectMake(215,10, 60, 30)];
            totalPayCount.text = @"0.00";
            totalPayCount.font = [UIFont systemFontOfSize:15.0];
            totalPayCount.textColor = [UIColor redColor];
            [cell addSubview:totalPayCountString];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell addSubview:totalPayCount];
        }
        return cell;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setOrderTableView:nil];
    [super viewDidUnload];
}

-(NSMutableArray *)goodsInfoList
{
   if(_goodsInfoList == nil)
   {
       _goodsInfoList = [[NSMutableArray alloc]init];
   }
    return _goodsInfoList;
}

-(NSMutableArray *)checkRadioArray
{
    if(_checkRadioArray == nil)
    {
        _checkRadioArray = [[NSMutableArray alloc]init];
    }
    return _checkRadioArray;
}
-(void)payAfterGetGoodsPressed:(id)sender
{
    for(UIButton *o in self.checkRadioArray)
    {
        [o setBackgroundImage:[UIImage imageNamed:@"RadioButton-Unselected"] forState:UIControlStateNormal];
    }
    payAfterCustomerGetGoods = YES;
    UIButton *pressedBtn = sender;
    [pressedBtn setBackgroundImage:[UIImage imageNamed:@"RadioButton-Selected"] forState:UIControlStateNormal];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.view.center = CGPointMake(160, 30);
    [self.view addGestureRecognizer:self.tapGestureRecgnizer];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.view removeGestureRecognizer:self.tapGestureRecgnizer];
    self.view.center = CGPointMake(160, self.view.frame.size.height/2);
}
-(void)payOnlinePressed:(id)sender
{
    for(UIButton *o in self.checkRadioArray)
    {
        [o setBackgroundImage:[UIImage imageNamed:@"RadioButton-Unselected"] forState:UIControlStateNormal];
    }
    payAfterCustomerGetGoods = NO;
    UIButton *pressedBtn = sender;
    [pressedBtn setBackgroundImage:[UIImage imageNamed:@"RadioButton-Selected"] forState:UIControlStateNormal];
    
}

-(UITapGestureRecognizer *)tapGestureRecgnizer
{
    if(_tapGestureRecgnizer == nil)
    {
        _tapGestureRecgnizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard:)];
        _tapGestureRecgnizer.numberOfTapsRequired = 1;
    }
    return  _tapGestureRecgnizer;
}

-(void)hideKeyBoard:(id)sender
{
    [self.orderRemarkFeild resignFirstResponder];
}
@end
