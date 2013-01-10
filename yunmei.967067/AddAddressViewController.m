//
//  AddAddressViewController.m
//  yunmei.967067
//
//  Created by ken on 13-1-10.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import "AddAddressViewController.h"

@interface AddAddressViewController ()

@end

@implementation AddAddressViewController
@synthesize addressTableView;
@synthesize goodsOwner = _goodsOwner;
@synthesize telephone = _telephone;
@synthesize addressInDetail = _addressInDetail;
@synthesize zipCode = _zipCode;
@synthesize provinceBtn = _provinceBtn;
@synthesize cityBtn = _cityBtn;
@synthesize countyBtn = _countyBtn;
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
    self.addressTableView.scrollEnabled = NO;
    // Do any additional setup after loading the view from its nib.
}

-(UITextField *)goodsOwner
{
    if(_goodsOwner == nil)
    {
        _goodsOwner = [[UITextField alloc]initWithFrame:CGRectMake(60, 10, 240, 30)];
        _goodsOwner.delegate = self;
        _goodsOwner.keyboardType = UIKeyboardTypeDefault;
    }
    [_goodsOwner setBorderStyle:UITextBorderStyleRoundedRect];
    _goodsOwner.tag =1;
    return  _goodsOwner;
}

-(UITextField *)telephone
{
    if(_telephone == nil)
    {
        _telephone = [[UITextField alloc]initWithFrame:CGRectMake(70, 10, 230, 30)];
        _telephone.delegate = self;
        _telephone.keyboardType = UIKeyboardTypeNumberPad;
    }
    [_telephone setBorderStyle:UITextBorderStyleRoundedRect];
    _telephone.tag =2;
    return  _telephone;
}


-(UITextField *)addressInDetail
{
    if(_addressInDetail == nil)
    {
        _addressInDetail = [[UITextField alloc]initWithFrame:CGRectMake(70, 10, 230, 30)];
        _addressInDetail.delegate =self;
        _addressInDetail.keyboardType = UIKeyboardTypeDefault;
    }
    [_addressInDetail setBorderStyle:UITextBorderStyleRoundedRect];
    _addressInDetail.tag =3;
    return  _addressInDetail;
}

-(UITextField *)zipCode
{
    if(_zipCode == nil)
    {
        _zipCode = [[UITextField alloc]initWithFrame:CGRectMake(45, 10, 255, 30)];
        _zipCode.delegate = self;
        _zipCode.keyboardType = UIKeyboardTypeNumberPad;
    }
    [_zipCode setBorderStyle:UITextBorderStyleRoundedRect];
    _zipCode.tag =4;
    return  _zipCode;
}

-(UIButton *)provinceBtn
{
    if(_provinceBtn == nil)
    {
        _provinceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_provinceBtn setFrame:CGRectMake(70, 10, 90, 30)];
        [_provinceBtn setTitle:@"请选择省" forState:UIControlStateNormal];
        [_provinceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _provinceBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        _provinceBtn.layer.borderWidth = 1;
        _provinceBtn.layer.borderWidth = 2;
        _provinceBtn.layer.borderColor = [YMUIButton CreateCGColorRef:160 greenNumber:160 blueNumber:160 alphaNumber:1.0];
        [_provinceBtn setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
    }
    return _provinceBtn;
}

-(UIButton *)cityBtn
{
    if(_cityBtn == nil)
    {
        _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cityBtn setFrame:CGRectMake(162, 10, 90, 30)];
        [_cityBtn setTitle:@"请选择市" forState:UIControlStateNormal];
        [_cityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cityBtn.layer.borderWidth = 2;
        _cityBtn.layer.borderColor = [YMUIButton CreateCGColorRef:160 greenNumber:160 blueNumber:160 alphaNumber:1.0];
        [_cityBtn setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
        _cityBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _cityBtn;
}

-(UIButton *)countyBtn
{
    if(_countyBtn == nil)
    {
        _countyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_countyBtn setFrame:CGRectMake(70, 43, 182, 30)];
        [_countyBtn setTitle:@"请选择县区" forState:UIControlStateNormal];
        [_countyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _countyBtn.layer.borderWidth = 1;
        _countyBtn.layer.borderWidth = 2;
        _countyBtn.layer.borderColor = [YMUIButton CreateCGColorRef:160 greenNumber:160 blueNumber:160 alphaNumber:1.0];
        [_countyBtn setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
         _countyBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _countyBtn;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 2)
    {
        return 80.0;
    }else{
        return 50.0;
    }
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath .row == 0)
    {
        static NSString *identifier = @"identifier0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            UILabel *ownerString = [[UILabel alloc]initWithFrame:CGRectMake(13, 15, 59, 15)];
            [ownerString setText:@"收货人:"];
            [ownerString setBackgroundColor:[UIColor clearColor]];
            [ownerString setFont:[UIFont systemFontOfSize:12.0]];
            [ownerString setTextColor:[UIColor grayColor]];
            [cell  addSubview:ownerString];
            [cell addSubview:self.goodsOwner];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        return cell;
    }else if (indexPath.row == 1){
        static NSString *identifier = @"identifier1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];            
            UILabel *ownerString = [[UILabel alloc]initWithFrame:CGRectMake(13, 15, 69, 15)];
            [ownerString setText:@"联系电话:"];
            [ownerString setFont:[UIFont systemFontOfSize:12.0]];
            [ownerString setTextColor:[UIColor grayColor]];
            [ownerString setBackgroundColor:[UIColor clearColor]];
            [cell  addSubview:ownerString];
            [cell addSubview:self.telephone];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        return cell;
    }else if (indexPath.row ==2){
        static NSString *identifier = @"identifier2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];            
            UILabel *ownerString = [[UILabel alloc]initWithFrame:CGRectMake(13, 15, 59, 15)];
            [ownerString setText:@"省市区:"];
            [ownerString setFont:[UIFont systemFontOfSize:12.0]];
            [ownerString setTextColor:[UIColor grayColor]];
            [ownerString setBackgroundColor:[UIColor clearColor]];
            [cell  addSubview:ownerString];
            [cell addSubview:self.provinceBtn];
            [cell addSubview:self.cityBtn];
            [cell addSubview:self.countyBtn];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        return cell;
    }else if (indexPath.row ==3){
        static NSString *identifier = @"identifier3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        {
            if(cell == nil)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];                
                UILabel *ownerString = [[UILabel alloc]initWithFrame:CGRectMake(13, 15, 69, 15)];
                [ownerString setText:@"详细地址:"];
                [ownerString setFont:[UIFont systemFontOfSize:12.0]];
                [ownerString setTextColor:[UIColor grayColor]];
                [ownerString setBackgroundColor:[UIColor clearColor]];
                [cell  addSubview:ownerString];
                [cell addSubview:self.addressInDetail];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
        }
        return cell;
    }else{
        static NSString *identifier = @"identifier4";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];            
            UILabel *ownerString = [[UILabel alloc]initWithFrame:CGRectMake(13, 15, 49, 15)];
            [ownerString setText:@"邮编:"];
            [ownerString setFont:[UIFont systemFontOfSize:12.0]];
            [ownerString setTextColor:[UIColor grayColor]];
            [ownerString setBackgroundColor:[UIColor clearColor]];
            [cell  addSubview:ownerString];
            [cell addSubview:self.zipCode];
           [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        return cell;
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.view addGestureRecognizer:self.tapGestureRecgnizer];
    if((textField.tag ==3)||(textField.tag ==4))
    {
        self.view.center = CGPointMake(160, 80);
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.view removeGestureRecognizer:self.tapGestureRecgnizer];
    self.view.center = CGPointMake(160, 208);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)hideKeyBoard:(id)sender
{
    NSLog(@"1111");
    [self.goodsOwner resignFirstResponder];
    [self.telephone resignFirstResponder];
    [self.addressInDetail resignFirstResponder];
    [self.zipCode resignFirstResponder];
}
- (void)viewDidUnload {
    [self setAddressTableView:nil];
    [super viewDidUnload];
}
@end
