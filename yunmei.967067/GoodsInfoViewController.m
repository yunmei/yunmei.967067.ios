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
@synthesize goodsTableView;
@synthesize sizeBtn;
@synthesize textControlToolbar;
@synthesize  firstResponderTextFeild;
@synthesize goodsImageScrollView = _goodsImageScrollView;

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
        NSLog(@"%@",[completedOperation responseString]);
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSMutableDictionary *object = [parser objectWithData:[completedOperation responseData]];
       if([(NSString *)[object objectForKey:@"errorMessage"]isEqualToString:@"success"])
       {                    
//这个是没有数组的
//           NSMutableDictionary *dataDic = [object objectForKey:@"data"];
//           self.goodsModel.goodsCode = [dataDic objectForKey:@"goodsCode"];
//           self.goodsModel.goodsMarketPrice = [dataDic objectForKey:@"goodsMarketPrice"];
//           self.goodsModel.goodsName = [dataDic objectForKey:@"goodsName"];
//           self.goodsModel.imageUrl = [dataDic objectForKey:@"imageUrl"];
//           self.goodsModel.property = [dataDic objectForKey:@"property"];
//           self.goodsModel.standard = [dataDic objectForKey:@"standard"];
//           self.goodsModel.store = [dataDic objectForKey:@"store"];
//           NSLog(@"%@",self.goodsModel.store);
//这个是有数组的
           NSMutableArray *dataArr = [object objectForKey:@"data"];
           NSMutableDictionary *dataDic = [dataArr objectAtIndex:0];
           self.goodsModel.goodsCode = [dataDic objectForKey:@"goodsCode"];
           self.goodsModel.goodsMarketPrice = [dataDic objectForKey:@"goodsMarketPrice"];
           self.goodsModel.goodsName = [dataDic objectForKey:@"goodsName"];
           self.goodsModel.imageUrl = [dataDic objectForKey:@"imageUrl"];
           self.goodsModel.property = [dataDic objectForKey:@"property"];
           self.goodsModel.standard = [dataDic objectForKey:@"standard"];
           self.goodsModel.store = [dataDic objectForKey:@"store"];
           NSLog(@"%@",self.goodsModel.store);
           [self.goodsTableView reloadData];
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
    [self setGoodsTableView:nil];
    [super viewDidUnload];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(tableView.tag == 0)
    {
        return 5;
    }else{
        if(section == 0)
        {
            return 2;
        }else{
            return 1;
        }
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 0)
    {
        if(indexPath.row == 0)
        {
            return 180;
        }else if (indexPath.row == 1)
        {
            return 75;
        }else if (indexPath.row ==2)
        {
            return  41;
        }else if (indexPath.row ==3)
        {
            return 101;
        }else{
            return 427;
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView.tag == 1)
    {
        return 3;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //当加载第一行时
    if(indexPath.row ==0)
    {
        static NSString *identifier = @"cellHeader";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            UIScrollView * imageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(30, 15, 260, 160)];
            imageScrollView.backgroundColor = [UIColor blueColor];
            imageScrollView.showsHorizontalScrollIndicator=YES;
            [cell.contentView addSubview:imageScrollView];
        }
        return cell;
    }else if(indexPath.row ==1)
    {
        static NSString *identifier = @"cellMiddle";
          UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        //产品名字
        UILabel *nameLable = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 320, 43)];
        nameLable.text = @"2012秋装新款韩款女装中长版";
        [cell addSubview:nameLable];
        //产品价格
        UILabel *priceLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 32, 101, 30)];
        priceLable.textColor = [UIColor redColor];
        priceLable.text = @"￥567.00";
        priceLable.font = [UIFont systemFontOfSize:15.0];
        [cell addSubview:priceLable];
        //产品市场价
        UILabel *marketPriceLable = [[UILabel alloc]initWithFrame:CGRectMake(103, 32, 150, 30)];
        marketPriceLable.text = @"市场价:￥986.00";
        marketPriceLable.textColor = [UIColor grayColor];
        marketPriceLable.font = [UIFont systemFontOfSize:15.0];
        [cell addSubview:marketPriceLable];
        }
        return cell;
    }else if (indexPath.row ==2)
    {
        static NSString * identifier = @"cellParams";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            //产品尺码
            UILabel *chiMaLable = [[UILabel alloc]initWithFrame:CGRectMake(12, 0, 40, 25)];
            chiMaLable.text = @"尺码:";
            chiMaLable.font = [UIFont systemFontOfSize:15.0];
            [cell addSubview:chiMaLable];
            //生成尺寸的选择框按钮
            UIButton *chiBtn1 = [YMUIButton CreateSizeButton:@"20" CGFrame:CGRectMake(55, 0, 40, 26)];
            UIButton *chiBtn2 = [YMUIButton CreateSizeButton:@"30" CGFrame:CGRectMake(95, 0, 40, 26)];
            UIButton *chiBtn3 = [YMUIButton CreateSizeButton:@"40" CGFrame:CGRectMake(135, 0, 40, 26)];
            UIButton *chiBtn4 = [YMUIButton CreateSizeButton:@"50" CGFrame:CGRectMake(175, 0, 40, 26)];
            //设置点击尺寸按钮时候的事件
            [chiBtn1 addTarget:self action:@selector(chiMaCliked:)forControlEvents:UIControlEventTouchUpInside];
            [chiBtn2 addTarget:self action:@selector(chiMaCliked:)forControlEvents:UIControlEventTouchUpInside];
            [chiBtn3 addTarget:self action:@selector(chiMaCliked:)forControlEvents:UIControlEventTouchUpInside];
            [chiBtn4 addTarget:self action:@selector(chiMaCliked:)forControlEvents:UIControlEventTouchUpInside];
            //将这些按钮加入cell视图
            [cell addSubview:chiBtn1];
            [cell addSubview:chiBtn2];
            [cell addSubview:chiBtn3];
            [cell addSubview:chiBtn4];
        }
        return cell;

    }else if (indexPath.row ==3)
    {
        static NSString * identifier = @"cellNum";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            //生成数量label
            UILabel *numLable = [[UILabel alloc]initWithFrame:CGRectMake(12, 2, 50, 20)];
            [numLable setText:@"数量:"];
            [cell addSubview:numLable];
            //生成button减
            UIButton *minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [minusBtn setBackgroundImage:[UIImage imageNamed:@"minusBtn.png"] forState:UIControlStateNormal];
            [minusBtn setFrame:CGRectMake(56, 0, 26, 26)];
            [minusBtn addTarget:self action:@selector(minusBtnPress:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:minusBtn];
            //生成数量text框
            UITextField *numFeild = [[UITextField alloc]initWithFrame:CGRectMake(84, 0, 40, 26)];
            [numFeild.layer setBorderWidth:1.0];
            [numFeild.layer setBorderColor:[YMUIButton CreateCGColorRef:128 greenNumber:128 blueNumber:128 alphaNumber:1.0]];
            [numFeild setText:@"1"];
            [numFeild setKeyboardType:UIKeyboardTypeNumberPad];
            self.firstResponderTextFeild = numFeild;
            //设置内容水平垂直居中
            [numFeild setTextAlignment:UITextAlignmentCenter];
            [numFeild setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
            [cell addSubview:numFeild];
            //生成加button
            UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [plusBtn setBackgroundImage:[UIImage imageNamed:@"plusBtn.png"] forState:UIControlStateNormal];
            [plusBtn setFrame:CGRectMake(126, 0, 26, 26)];
            [plusBtn addTarget:self action:@selector(plusBtnPress:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:plusBtn];
            //为文本域输入添加一个控制键盘的toolbar
            UIToolbar *keyBordTopBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 160, 320, 40)];
            [keyBordTopBar setBarStyle:UIBarStyleBlackTranslucent];
            UIBarButtonItem *cancleBtn = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancleBtnClick:)];
            UIBarButtonItem *confirmBtn = [[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStyleBordered target:self action:@selector(confirmBtnClick:)];
            UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            [cancleBtn setWidth:60.0];
            [flexibleSpace setWidth:190.0];
            [confirmBtn setWidth:60.0];
            [confirmBtn setAccessibilityActivationPoint:CGPointMake(282, 18)];
            NSArray *buttons = [[NSArray alloc]initWithObjects:cancleBtn,flexibleSpace,confirmBtn, nil];
            [keyBordTopBar setItems:buttons];
            self.textControlToolbar = keyBordTopBar;
            //为文本框绑定事件，获得焦点时弹出toolbar
            numFeild.delegate = self;
            //生成立即购买按钮
            UIButton *quickBuyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            //[quickBuyBtn setBackgroundImage:[UIImage imageNamed:<#(NSString *)#>] forState:<#(UIControlState)#>]
            
        }
        return cell;
    }else if (indexPath.row ==4)
    {
        static NSString *identifier = @"goodsDetailLable";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        return  cell;
    }else
    {
        static NSString *identifier = @"cellNon";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        return cell;

    }
}

//尺码按钮绑定的事件
-(void)chiMaCliked:(id)sender
{
    if(self.sizeBtn != nil)
    {
        [self.sizeBtn setBackgroundColor:[UIColor whiteColor]];
    }
    UIButton *PressedBtn = sender;
    self.sizeBtn = sender;
    [PressedBtn setBackgroundColor:[UIColor grayColor]];
    NSLog(@"%@",[sender titleLabel].text);
}

//颜色按钮绑定事件
-(void)colorBtnCliked:(id)sender
{
    if(self.colorBtn !=nil)
    {
        NSLog(@"notnil");
        CGColorRef witeColor = [YMUIButton CreateCGColorRef:255 greenNumber:255 blueNumber:255 alphaNumber:1.0];
        [self.colorBtn.layer setBorderColor:witeColor];
    }
    UIButton *PressedBtn = sender;
    self.colorBtn = sender;
    CGColorRef borderColor = [YMUIButton CreateCGColorRef:228 greenNumber:228 blueNumber:228 alphaNumber:1.0];
    [PressedBtn.layer setBorderColor:borderColor];
    
}

//点击数量文本域时候弹出toolbar事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.firstResponderTextFeild setText:@""];
    [self.view.superview addSubview:self.textControlToolbar];
}

//绑定toobar取消按钮的事件
-(void)cancleBtnClick:(id)sender
{
    [self.firstResponderTextFeild setText:@"1"];
    [self.firstResponderTextFeild resignFirstResponder];
    [self.textControlToolbar removeFromSuperview];
    [self.firstResponderTextFeild resignFirstResponder];
}

//绑定toobar确认按钮
-(void)confirmBtnClick:(id)sender
{
    NSLog(@"%@",self.firstResponderTextFeild.text);
    [self.firstResponderTextFeild resignFirstResponder];
    [self.textControlToolbar removeFromSuperview];
}

//绑定plusBtnPress这个加号按钮事件
-(void)plusBtnPress:(id)sender
{
    NSInteger i = [self.firstResponderTextFeild.text integerValue];
        i++;
    self.firstResponderTextFeild.text = [NSString stringWithFormat:@"%i",i];
    
}

//绑定minusBtnPress这个减号按钮事件
-(void)minusBtnPress:(id)sender
{
    NSUInteger i = [self.firstResponderTextFeild.text integerValue];
    if(i > 1)
    {
        i--;
    }
    self.firstResponderTextFeild.text = [NSString stringWithFormat:@"%i",i];
}
@end
