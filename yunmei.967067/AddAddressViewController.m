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
@synthesize picker = _picker;
@synthesize provinceArr = _provinceArr;
@synthesize cityArr = _cityArr;
@synthesize countyArr = _countyArr;
@synthesize provinceIdArr = _provinceIdArr;
@synthesize provinceNameArr = _provinceNameArr;
@synthesize cityIdArr = _cityIdArr;
@synthesize cityNameArr = _cityNameArr;
@synthesize countyIdArr = _countyIdArr;
@synthesize countyNameArr = _countyNameArr;
@synthesize confirmToolBar;
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
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    self.addressTableView.scrollEnabled = NO;
    // Do any additional setup after loading the view from its nib.
    UIButton *submitBtn = [[UIButton alloc]initWithFrame:CGRectMake(110, 297, 104, 33)];
    [submitBtn setBackgroundImage:[UIImage imageNamed:@"btn_yellow"] forState:UIControlStateNormal];
    [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(addressSubmit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"system_getProvinceList",@"act",nil];
    MKNetworkOperation * op = [YMGlobal getOperation:params];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSMutableDictionary *returnObj = [parser objectWithData:[completedOperation responseData]];
        if([[returnObj objectForKey:@"errorMessage"]isEqualToString:@"success"])
        {
            self.provinceArr = [returnObj objectForKey:@"data"];
            //获取省ID
            self.provinceIdArr = [self getAllId:self.provinceArr identifier:@"provinceId"];
            //获取省name
            self.provinceNameArr = [self getAllName:self.provinceArr identifier:@"provinceName"];
            [self.view addSubview:self.picker];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"Error:%@",error);
    }];
    [ApplicationDelegate.appEngine enqueueOperation:op];
    [HUD hide:YES];
    
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

-(UIPickerView *)picker
{
    if(_picker == nil)
    {
        _picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 480, 320, 290)];
        _picker.dataSource = self;
        _picker.delegate = self;
        _picker.showsSelectionIndicator = YES;
    }
    return  _picker;
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

-(NSMutableArray *)provinceArr
{
    if(_provinceArr == nil)
    {
        _provinceArr = [[NSMutableArray alloc]init];
    }
    
    return  _provinceArr;
}

-(NSMutableArray *)cityArr
{
    if(_cityArr == nil)
    {
        _cityArr = [[NSMutableArray alloc]init];
    }
    return  _cityArr;
}

-(NSMutableArray *)countyArr
{
    if(_countyArr == nil)
    {
        _countyArr = [[NSMutableArray alloc]init];
    }
    return _cityArr;
}
-(NSMutableArray *)provinceIdArr
{
    if(_provinceIdArr == nil)
    {
        _provinceIdArr = [[NSMutableArray alloc]init];
    }
    return _provinceIdArr;
}
-(NSMutableArray *)provinceNameArr
{
    if(_provinceNameArr == nil)
    {
        _provinceNameArr = [[NSMutableArray alloc]init];
    }
    return _provinceNameArr;
}

-(NSMutableArray *)cityNameArr
{
    if(_cityNameArr == nil)
    {
        _cityNameArr = [[NSMutableArray alloc]init];
    }
    return _cityNameArr;
}
-(NSMutableArray *)cityIdArr
{
    if(_cityIdArr == nil)
    {
        _cityIdArr = [[NSMutableArray alloc]init];
    }
    return _cityIdArr;
}

-(NSMutableArray *)countyNameArr
{
    if(_countyNameArr == nil)
    {
        _countyNameArr = [[NSMutableArray alloc]init];
    }
    return _countyNameArr;
}
-(NSMutableArray *)countyIdArr
{
    if(_countyIdArr == nil)
    {
        _countyIdArr = [[NSMutableArray alloc]init];
    }
    return _countyIdArr;
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
        [_provinceBtn addTarget:self action:@selector(getPicker:) forControlEvents:UIControlEventTouchUpInside];
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
        [_cityBtn addTarget:self action:@selector(getPicker:) forControlEvents:UIControlEventTouchUpInside];
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
        [_countyBtn setTitle:@"请选择地区" forState:UIControlStateNormal];
        [_countyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _countyBtn.layer.borderWidth = 1;
        _countyBtn.layer.borderWidth = 2;
        _countyBtn.layer.borderColor = [YMUIButton CreateCGColorRef:160 greenNumber:160 blueNumber:160 alphaNumber:1.0];
        [_countyBtn setBackgroundImage:[UIImage imageNamed:@"btn_gray"] forState:UIControlStateNormal];
         _countyBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_countyBtn addTarget:self action:@selector(getPicker:) forControlEvents:UIControlEventTouchUpInside];
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
    self.view.center = CGPointMake(160, 183);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)hideKeyBoard:(id)sender
{
    [self.goodsOwner resignFirstResponder];
    [self.telephone resignFirstResponder];
    [self.addressInDetail resignFirstResponder];
    [self.zipCode resignFirstResponder];
    
}
- (void)viewDidUnload {
    [self setAddressTableView:nil];
    [super viewDidUnload];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
    {
        return [self.provinceNameArr count];
    }else if (component ==1)
    {
        return [self.cityNameArr count];
    }else{
        return [self.countyNameArr count];
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0)
    {
        return [self.provinceNameArr objectAtIndex:row];
    }else if (component == 1)
    {
        return [self.cityNameArr objectAtIndex:row];
    }else{
        if([self.countyNameArr count] == 0)
        {
            return @"";
        }else{
            return [self.countyNameArr objectAtIndex:row];
        }
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component == 0)
    {
        NSString *seletedProvinceId = [self.provinceIdArr objectAtIndex:row];
        self.provinceBtn.tag = [seletedProvinceId integerValue];
        self.provinceBtn.titleLabel.text = [self.provinceNameArr objectAtIndex:row];
        [self getchildArr:seletedProvinceId identifierForAct:@"system_getCityList" identifierForFatherName:@"province_id" isCity:NO];
    }else if (component == 1)
    {
        NSString *seletedCityId = [self.cityIdArr objectAtIndex:row];
        self.cityBtn.tag = [seletedCityId integerValue];
        self.cityBtn.titleLabel.text = [self.cityNameArr objectAtIndex:row];
        [self getchildArr:seletedCityId identifierForAct:@"system_getDistrictList" identifierForFatherName:@"city_id" isCity:YES];
    }else if (component == 2)
    {
        self.countyBtn.tag = [[self.countyIdArr objectAtIndex:row] integerValue];
        self.countyBtn.titleLabel.text = [self.countyNameArr objectAtIndex:row];
    }
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 106;
}

-(NSMutableArray *)getAllId:(NSMutableArray *)fatherArr
                 identifier:(NSString *)identifier
{
    NSMutableArray * idArr = [[NSMutableArray alloc]init];
    for(NSMutableDictionary * o in fatherArr)
    {
        [idArr addObject:[o objectForKey:identifier]];
    }
    return idArr;
}

-(NSMutableArray *)getAllName:(NSMutableArray *)fatherArr
                 identifier:(NSString *)identifier
{
    NSMutableArray * nameArr = [[NSMutableArray alloc]init];
    for(NSMutableDictionary * o in fatherArr)
    {
        [nameArr addObject:[o objectForKey:identifier]];
    }
    return nameArr;
}

-(void)getPicker:(id)sender
{
    [self.picker setFrame:CGRectMake(0, 250, 320, 230)];
    //为文本域输入添加一个控制键盘的toolbar
    UIToolbar *keyBordTopBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 210, 320, 40)];
    [keyBordTopBar setBarStyle:UIBarStyleBlackTranslucent];
    UIBarButtonItem *cancleBtn = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancleBtnClick:)];
    UIBarButtonItem *confirmBtn = [[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStyleBordered target:self action:@selector(confirmBtnClick:)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [cancleBtn setWidth:60.0];
    [flexibleSpace setWidth:190.0];
    [confirmBtn setWidth:60.0];
    NSArray *buttons = [[NSArray alloc]initWithObjects:cancleBtn,flexibleSpace,confirmBtn, nil];
    [keyBordTopBar setItems:buttons];
    self.confirmToolBar = keyBordTopBar;
    [self.view addSubview:keyBordTopBar];
}

-(void)getchildArr:(NSString *)fatherId
        identifierForAct:(NSString *)identifierForAct
 identifierForFatherName:(NSString *)identifierForFatherName
                isCity:(bool)isCity
{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithObjectsAndKeys:identifierForAct,@"act",fatherId,identifierForFatherName,nil];
    MKNetworkOperation *op = [YMGlobal getOperation:param];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSMutableDictionary *obj = [parser objectWithData:[completedOperation responseData]];
        if([[obj objectForKey:@"errorMessage"]isEqualToString:@"success"])
        {
            NSMutableArray *cityData = [obj objectForKey:@"data"];
            if(!isCity)
            {
                self.cityIdArr = [self getAllId:cityData identifier:@"city_id"];
                self.cityNameArr = [self getAllName:cityData identifier:@"city_name"];
                [self.picker reloadComponent:1];
            }else{
                self.countyIdArr = [self getAllId:cityData identifier:@"district_id"];
                self.countyNameArr = [self getAllName:cityData identifier:@"district_name"];
                NSLog(@"%@",self.countyNameArr);
                [self.picker reloadComponent:2];
            }
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"%@",error);
    }];
    [ApplicationDelegate.appEngine enqueueOperation:op];
    [HUD hide:YES];
}

-(void)cancleBtnClick:(id)sender
{
    self.provinceBtn.titleLabel.text = @"请选择省";
    self.provinceBtn.tag = 0;
    self.cityBtn.titleLabel.text = @"请选择市";
    self.cityBtn.tag = 0;
    self.countyBtn.tag = 0;
    self.countyBtn.titleLabel.text = @"请选择地区";
    [self.picker setFrame:CGRectMake(0, 480, 320, 290)];
    [self.confirmToolBar removeFromSuperview];
}

-(void)confirmBtnClick:(id)sender
{
    [self.picker setFrame:CGRectMake(0, 480, 320, 290)];
    [self.confirmToolBar removeFromSuperview];
}

-(void)addressSubmit:(id)sender
{
    if([self.goodsOwner.text isEqualToString:@""]||(self.goodsOwner.text == nil))
    {
        UIAlertView *alertNum = [[UIAlertView alloc]initWithTitle:@"警告" message:@"请填写收货人信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertNum show];
    }else if ((self.telephone.text == nil)||[self.telephone.text isEqualToString:@""]){
        UIAlertView *alertNum = [[UIAlertView alloc]initWithTitle:@"警告" message:@"请填写联系电话" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertNum show];
    }else if((self.addressInDetail.text == nil)||[self.addressInDetail.text isEqualToString:@""]){
        UIAlertView *alertNum = [[UIAlertView alloc]initWithTitle:@"警告" message:@"请填写详细地址" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertNum show];
    }else if((self.zipCode.text == nil)||[self.zipCode.text isEqualToString:@""])
    {
        UIAlertView *alertNum = [[UIAlertView alloc]initWithTitle:@"警告" message:@"请填写邮编" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertNum show];
    }else if([self.provinceBtn.titleLabel.text isEqualToString:@"请选择省"]){
        UIAlertView *alertNum = [[UIAlertView alloc]initWithTitle:@"警告" message:@"请选择省" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertNum show];
    }else if ([self.cityBtn.titleLabel.text isEqualToString:@"请选择市"]){
        UIAlertView *alertNum = [[UIAlertView alloc]initWithTitle:@"警告" message:@"请选择市" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertNum show];
    }else if ([self.countyBtn.titleLabel.text isEqualToString:@"请选择地区"]){
        UIAlertView *alertNum = [[UIAlertView alloc]initWithTitle:@"警告" message:@"请选择地区" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertNum show];
    }else{
        OrderEditViewController *orderEdit = [[OrderEditViewController alloc]initWithNibName:@"OrderEditViewController" bundle:nil];
        NSString * area = [NSString stringWithFormat:@"mainland:%@/%@/%@:%i",self.provinceBtn.titleLabel.text,self.cityBtn.titleLabel.text,self.countyBtn.titleLabel.text,self.countyBtn.tag];
        NSString *displayArea = [NSString stringWithFormat:@"%@%@%@%@",self.self.provinceBtn.titleLabel.text,self.cityBtn.titleLabel.text,self.countyBtn.titleLabel.text,self.addressInDetail.text];
        [orderEdit.addressDic setObject:area forKey:@"ship_area"];
        [orderEdit.addressDic setObject:self.addressInDetail.text forKey:@"ship_addr"];
        [orderEdit.addressDic setObject:self.zipCode.text forKey:@"ship_zip"];
        [orderEdit.addressDic setObject:self.goodsOwner.text forKey:@"ship_name"];
        [orderEdit.addressDic setObject:self.telephone.text forKey:@"ship_tel"];
        [orderEdit.addressDic setObject:displayArea forKey:@"displayArea"];
        if([UserModel checkLogin])
        {
            UserModel *user = [UserModel getUserModel];
            NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"user_updateAddressInfo",@"act",user.session,@"sessionId",user.userid,@"userId",@"0",@"addressId",self.goodsOwner.text,@"name", self.telephone.text,@"phone",[NSString stringWithFormat:@"%i",self.provinceBtn.tag],@"provinceId",[NSString stringWithFormat:@"%i",self.cityBtn.tag],@"cityId",[NSString stringWithFormat:@"%i",self.countyBtn.tag],@"areaId",displayArea,@"address",self.zipCode.text,@"zipcode",nil];
            MKNetworkOperation *op = [YMGlobal getOperation:params];
            [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
                NSLog(@"%@",[completedOperation responseString]);
            } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
                NSLog(@"%@",error);
            }];
            [ApplicationDelegate.appEngine enqueueOperation:op];
            
            //
            NSMutableDictionary *getAddressParams = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"user_getAddressList",@"act",user.session,@"sessionId",user.userid,@"userId",nil];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
            MKNetworkOperation *op1 = [YMGlobal getOperation:getAddressParams];
            [op1 addCompletionHandler:^(MKNetworkOperation *completedOperation) {
                SBJsonParser *parser = [[SBJsonParser alloc]init];
                NSMutableDictionary *obj = [parser objectWithData:[completedOperation responseData]];
                if([[obj objectForKey:@"errorMessage"] isEqualToString:@"success"])
                {
                    orderEdit.userAddressArr = [obj objectForKey:@"data"];
                    UINavigationController *orderNav = [[UINavigationController alloc]initWithRootViewController:orderEdit];
                    [orderNav.navigationBar setTintColor:[UIColor colorWithRed:237/255.0f green:144/255.0f blue:6/255.0f alpha:1]];
                    if([orderNav.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
                    {
                        [orderNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_bg"] forBarMetrics: UIBarMetricsDefault];
                    }
                    [self.navigationController presentModalViewController:orderNav animated:YES];
                }
            }errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
                NSLog(@"%@",error);
            }];
            [ApplicationDelegate.appEngine enqueueOperation:op1];
            [hud hide:YES];

        }else{
            UINavigationController *orderNav = [[UINavigationController alloc]initWithRootViewController:orderEdit];
            [orderNav.navigationBar setTintColor:[UIColor colorWithRed:237/255.0f green:144/255.0f blue:6/255.0f alpha:1]];
            if([orderNav.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
            {
                [orderNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_bg"] forBarMetrics: UIBarMetricsDefault];
            }
            [self.navigationController presentModalViewController:orderNav animated:YES];
        }

    }
}
@end
