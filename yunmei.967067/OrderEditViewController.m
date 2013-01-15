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
@synthesize addressDic = _addressDic;
@synthesize countPay;
@synthesize userAddressArr = _userAddressArr;
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
    self.countPay = [NSString stringWithFormat:@"%.2f",[self statisPay]];
}

-(void)bindCar
{
    YMDbClass *db = [[YMDbClass alloc]init];
    if([db connect])
    {
        NSString *query = [NSString stringWithFormat:@"SELECT goodsid ,goods_code,goods_name,goods_price,goods_store,proid,goods_count FROM goodslist_car;"];
        self.goodsInfoList = [db fetchAll:query];
        self.countPay = [db count_sum:@"goodslist_car" tablefiled:@"goods_count"];
        [db close];
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
        if([self.addressDic count]>0)
            return 110;
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
            if([self.addressDic count] >0)
            {
                UILabel *goodsOwnerLable = [[UILabel alloc]initWithFrame:CGRectMake(3, 25, 300, 20)];
                UILabel *zipIdLable = [[UILabel alloc]initWithFrame:CGRectMake(3, 45, 300, 20)];
                UILabel *telephoneLable = [[UILabel alloc]initWithFrame:CGRectMake(3, 65, 300, 20)];
                UILabel *displayAreaLable = [[UILabel alloc]initWithFrame:CGRectMake(3, 85, 300, 20)];
                NSString *goodsOwner = [NSString stringWithFormat:@"收货人姓名:%@",[self.addressDic objectForKey:@"ship_name" ]];
                NSString *zipId = [NSString stringWithFormat:@"收货人邮编:%@",[self.addressDic objectForKey:@"ship_zip" ]];
                NSString *telephone = [NSString stringWithFormat:@"收货人电话:%@",[self.addressDic objectForKey:@"ship_tel" ]];
                NSString *displayArea = [NSString stringWithFormat:@"收货地址:%@",[self.addressDic objectForKey:@"displayArea"]];
                goodsOwnerLable.text = goodsOwner;
                zipIdLable.text = zipId;
                telephoneLable.text = telephone;
                displayAreaLable.text = displayArea;
                goodsOwnerLable.font = [UIFont systemFontOfSize:12.0];
                zipIdLable.font = [UIFont systemFontOfSize:12.0];
                telephoneLable.font = [UIFont systemFontOfSize:12.0];
                displayAreaLable.font = [UIFont systemFontOfSize:12.0];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                [cell addSubview:goodsOwnerLable];
                [cell addSubview:zipIdLable];
                [cell addSubview:telephoneLable];
                [cell addSubview:displayAreaLable];
            }else{
                UILabel *pleaseWriteInAddress = [[UILabel alloc]initWithFrame:CGRectMake(3, 25, 100, 20)];
                pleaseWriteInAddress.text = @"请填写收货地址";
                pleaseWriteInAddress.font = [UIFont systemFontOfSize:12.0];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                [cell addSubview:pleaseWriteInAddress];
            }
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
            UILabel *totalPayCountString = [[UILabel alloc]initWithFrame:CGRectMake(200, 5, 40, 30)];
            totalPayCountString.text = @"总金额:";
            totalPayCountString.font = [UIFont systemFontOfSize:12.0];
            UILabel *totalPayCount = [[UILabel alloc]initWithFrame:CGRectMake(240,5,80,30)];
            totalPayCount.text = [@"￥" stringByAppendingString:self.countPay];
            totalPayCount.font = [UIFont systemFontOfSize:15.0];
            totalPayCount.textColor = [UIColor redColor];
            [totalPayCount setFont:[UIFont systemFontOfSize:12.0]];
            UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(110, 5, 60, 30)];
            [submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
            submitBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
            [submitBtn setBackgroundImage:[UIImage imageNamed:@"btn_yellow"] forState:UIControlStateNormal];
            [submitBtn addTarget:self action:@selector(submitOrder:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:totalPayCountString];
            [cell addSubview:submitBtn];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell addSubview:totalPayCount];
        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row ==0)
    {
        if([UserModel checkLogin])
        {
            
        }
        AddAddressViewController *addressView = [[AddAddressViewController alloc]init];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
        self.navigationItem.backBarButtonItem = backItem;
        [self.navigationController pushViewController:addressView animated:YES];
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

-(NSMutableDictionary *)addressDic
{
    if(_addressDic == nil)
    {
        _addressDic = [[NSMutableDictionary alloc]init];
    }
    return _addressDic;
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

-(NSMutableArray *)userAddressArr
{
    if(_userAddressArr == nil)
    {
        _userAddressArr = [[NSMutableArray alloc]init];
    }
    return  _userAddressArr;
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

-(CGFloat)statisPay
{
    if([self.goodsInfoList count]>0)
    {
        CGFloat i = 0.00;
        for(NSMutableDictionary *o in self.goodsInfoList)
        {
            CGFloat multiPal = (CGFloat)([[o objectForKey:@"goods_count"] integerValue] *[[o objectForKey:@"goods_price"] integerValue]);
            i += multiPal;
        }
        return i;
    }else{
        return  0.00;
    }
}

-(void)submitOrder:(id)sender
{
   if([self.addressDic count] == 0)
   {
      UIAlertView *alertAddress = [[UIAlertView alloc]initWithTitle:@"警告" message:@"请填写售货人信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
       [alertAddress show];
   }else if ([self.orderRemarkFeild.text isEqualToString:@""]||(self.orderRemarkFeild.text == nil)){
       UIAlertView *alertAddress = [[UIAlertView alloc]initWithTitle:@"警告" message:@"请填写订单备注" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
       [alertAddress show];
   }else{
       GetOrderIdViewController *getOrder = [[GetOrderIdViewController alloc]initWithNibName:@"GetOrderIdViewController" bundle:nil];
       if(payAfterCustomerGetGoods == NO)
       {
           getOrder.payOnline = YES;
       }
       [getOrder.orderParamsDic setObject:[self.addressDic objectForKey:@"ship_area"] forKey:@"ship_area"];
       [getOrder.orderParamsDic setObject:[self.addressDic objectForKey:@"ship_addr"] forKey:@"ship_addr"];
       [getOrder.orderParamsDic setObject:[self.addressDic objectForKey:@"ship_name"] forKey:@"ship_name"];
       [getOrder.orderParamsDic setObject:[self.addressDic objectForKey:@"ship_zip"] forKey:@"ship_zip"];
       [getOrder.orderParamsDic setObject:[self.addressDic objectForKey:@"ship_tel"] forKey:@"ship_tel"];
       [getOrder.orderParamsDic setObject:self.orderRemarkFeild.text forKey:@"memo"];
       NSString *cart_goodids = @"";
        NSString *cart_goodnums = @"";
        NSString *productIds = @"";
       int i =1;
       for(NSMutableDictionary *o in self.goodsInfoList)
       {
          cart_goodids = [cart_goodids stringByAppendingString:[o objectForKey:@"goodsid"]];
          cart_goodnums = [cart_goodnums stringByAppendingString:[o objectForKey:@"goods_count"]];
          productIds = [productIds stringByAppendingString:[o objectForKey:@"proid"]];
           if(i != [self.goodsInfoList count])
           {
              cart_goodids = [cart_goodids stringByAppendingString:@","];
              cart_goodnums = [cart_goodnums stringByAppendingString:@","];
               productIds = [productIds stringByAppendingString:@","];
           }
           i++;
       }
       [getOrder.orderParamsDic setObject:@"14" forKey:@"shipping_id"];
       [getOrder.orderParamsDic setObject:cart_goodids forKey:@"cart_goodids"];
       [getOrder.orderParamsDic setObject:cart_goodnums forKey:@"cart_goodnums"];
       [getOrder.orderParamsDic setObject:productIds forKey:@"productIds"];
       UINavigationController *orderNav = [[UINavigationController alloc]initWithRootViewController:getOrder];
       [orderNav.navigationBar setTintColor:[UIColor colorWithRed:237/255.0f green:144/255.0f blue:6/255.0f alpha:1]];
       if([orderNav.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
       {
           [orderNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_bg"] forBarMetrics: UIBarMetricsDefault];
       }
       [self.navigationController presentModalViewController:orderNav animated:YES];
   }
}
@end
