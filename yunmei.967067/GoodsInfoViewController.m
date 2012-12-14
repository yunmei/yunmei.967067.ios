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
@synthesize goodsDetailTableView = _goodsDetailTableView;
@synthesize goodsImagesArr= _goodsImagesArr;
@synthesize specArr = _specArr;
@synthesize goodsDictionary = _goodsDictionary;
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
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSMutableDictionary *object = [parser objectWithData:[completedOperation responseData]];
       if([(NSString *)[object objectForKey:@"errorMessage"]isEqualToString:@"success"])
       {                    
           NSMutableArray *dataArr = [object objectForKey:@"data"];
           NSMutableDictionary *dataDic = [dataArr objectAtIndex:0];
           self.goodsModel.goodsCode = [dataDic objectForKey:@"goodsCode"];
           self.goodsModel.goodsMarketPrice = [dataDic objectForKey:@"goodsMarketPrice"];
           self.goodsModel.goodsName = [dataDic objectForKey:@"goodsName"];
           self.goodsModel.imageUrl = [dataDic objectForKey:@"imageUrl"];
           self.goodsModel.property = [dataDic objectForKey:@"property"];
           self.goodsModel.standard = [dataDic objectForKey:@"standard"];
           self.goodsModel.store = [dataDic objectForKey:@"store"];
           self.specArr = [dataDic objectForKey:@"spec"];
           [self.goodsTableView reloadData];
       }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"Error:%@",error);
    }];
    //发送图片请求
    NSMutableDictionary *imageParam = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"goods_getImagesByGoodsId",@"act",self.goodsId,@"goodsId", nil];
    MKNetworkOperation *imageOp = [YMGlobal getOperation:imageParam];
    [imageOp addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJsonParser *imageParser = [[SBJsonParser alloc]init];
        NSMutableDictionary *object = [imageParser objectWithData:[completedOperation responseData]];
        self.goodsImagesArr = [NSArray arrayWithArray:[object objectForKey:@"data"]];
        [self displayImages];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"%@",error);
    }];
    self.goodsDetailTableView.tag =1;
    self.goodsDetailTableView.delegate = self;
    self.goodsDetailTableView.dataSource = self;
    self.goodsDetailTableView.scrollEnabled = NO;
    self.goodsDetailTableView.backgroundColor = [UIColor whiteColor];
    [hud hide:YES];
    [ApplicationDelegate.appEngine enqueueOperation:op];
    [ApplicationDelegate.appEngine enqueueOperation:imageOp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//加载头部图片
-(void)displayImages
{
    int i = [self.goodsImagesArr count];
    if(i >0)
    {
        for(UIView *imageView in[self.goodsImageScrollView subviews])
        {
            [imageView removeFromSuperview];
        }
        self.goodsImageScrollView.contentSize = CGSizeMake(258*i, 170);
        int numb = 1;
        for(NSString *o in self.goodsImagesArr)
        {
            UIImageView  *goodsImageView = [[UIImageView alloc]initWithFrame:CGRectMake((numb-1)*258, 10, 258,170)];
            [goodsImageView setImage:[UIImage imageNamed:@"goods_default.png"]];
            [YMGlobal loadImage:o andImageView:goodsImageView];
            [self.goodsImageScrollView addSubview:goodsImageView];
            numb ++;
        }
    }
}

-(NSMutableDictionary *)goodsDictionary
{
    if(_goodsDictionary == nil)
    {
        _goodsDictionary = [[NSMutableDictionary alloc]init];
    }
    return _goodsDictionary;
}

-(NSMutableArray *)specArr
{
    if(_specArr == nil)
    {
        _specArr = [[NSMutableArray alloc]init];
    }
    return _specArr;
}

-(GoodsModel *)goodsModel
{
    if(_goodsModel == nil)
    {
        _goodsModel = [[GoodsModel alloc]init];
    }
    return _goodsModel;
}


-(UIScrollView *)goodsImageScrollView
{
    if(_goodsImageScrollView == nil)
    {
        _goodsImageScrollView = [[UIScrollView alloc]init];
    }
    return _goodsImageScrollView;
}

-(UITableView *)goodsDetailTableView
{
    if(_goodsDetailTableView == nil)
    {
        _goodsDetailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 20, 320, 420) style:UITableViewStyleGrouped];
    }
    return _goodsDetailTableView;
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
            int i =1;
            if([self.specArr count] ==0)
            {
                return  41;
            }else{
                i = (int)[self.specArr  count];
                    return  41*i;
            }
            
        }else if (indexPath.row ==3)
        {
            return 101;
        }else{
            return 500;
        }
    }else{
        if(indexPath.section == 0)
        {
            return 130;
        }else{
            return  30;
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
    if(tableView.tag ==0)
    {
        //当加载第一行时
        if(indexPath.row ==0)
        {
            static NSString *identifierHeader = @"cellHeader";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierHeader];
            if(cell == nil)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierHeader];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                self.goodsImageScrollView.frame = CGRectMake(31, 5, 258, 170);
                self.goodsImageScrollView.bounces = YES;
                self.goodsImageScrollView.pagingEnabled = YES;
                UIImageView *imageViewChangeScroll = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 258, 170)];
                [imageViewChangeScroll setImage:[UIImage imageNamed:@"ad_default"]];
                [self.goodsImageScrollView addSubview:imageViewChangeScroll];
                //给滚动图片左边加一个向左小箭头
                UIButton *leftMoveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [leftMoveBtn setFrame:CGRectMake(8, 79, 20, 24)];
                [leftMoveBtn setBackgroundImage:[UIImage imageNamed:@"moveLeft.png"] forState:UIControlStateNormal];
                //为这个箭头绑定一个事件
                [leftMoveBtn addTarget:self action:@selector(leftMoveBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
                //给滚动图片左边加一个向右小箭头
                UIButton *rightMoveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                [rightMoveBtn setFrame:CGRectMake(293, 79, 20, 24)];
                [rightMoveBtn setBackgroundImage:[UIImage imageNamed:@"moveRight.png"] forState:UIControlStateNormal];
                //为这个箭头绑定一个事件
                [rightMoveBtn addTarget:self action:@selector(rightMoveBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:self.goodsImageScrollView];
                [cell addSubview:rightMoveBtn];
                [cell addSubview:leftMoveBtn];
            }
            return cell;
        }else if(indexPath.row ==1)
        {
            static NSString *identifierMiddle = @"cellMiddle";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierMiddle];
            if(cell == nil)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierMiddle];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
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
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }else{
                
                int paramCount = 1;
                for(id o in self.specArr)
                {
                    //属性
                    UILabel *paramLable = [[UILabel alloc]initWithFrame:CGRectMake(12, 0+(paramCount - 1)*41, 40, 25)];
                    paramLable.font = [UIFont systemFontOfSize:15.0];
                    paramLable.text = [o objectForKey:@"spec_name"];
                    NSMutableArray *paramBtnArr = [o objectForKey:@"spec_values"];
                    //按钮计数器
                    int btnCount = 1;
                    for(NSMutableDictionary *k in paramBtnArr)
                    {
                        UIButton *paramBtn = [YMUIButton CreateSizeButton:[k objectForKey:@"specValue"] CGFrame:CGRectMake(55+(btnCount -1)*50, 0+(paramCount - 1)*41, 50, 26)];
                        //将该属性的ID设置为其tag
                        [paramBtn setTag:[[k objectForKey:@"specValueId"] integerValue]];
                        //设置该按钮字体
                        paramBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
                        //设置该按钮的事件
                        [paramBtn addTarget:self action:@selector(chiMaCliked:)forControlEvents:UIControlEventTouchUpInside];
                        [cell addSubview:paramBtn];
                        btnCount++;
                    }
                    paramCount ++;
                    [cell addSubview:paramLable];
                }
            }
            return cell;
            
        }else if (indexPath.row ==3)
        {
            static NSString * identifierNum = @"cellNum";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifierNum];
            if(cell == nil)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierNum];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
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
                [quickBuyBtn setBackgroundImage:[UIImage imageNamed:@"quickBuyBtn"] forState:UIControlStateNormal];
                [quickBuyBtn setFrame:CGRectMake(55, 45, 200, 40)];
                [cell addSubview:quickBuyBtn];
                
            }
            return cell;
        }else
        {
            static NSString *identifierDetail = @"goodsDetailLable";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierDetail];
            if(cell == nil)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierDetail];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                UILabel *goodsDetailLable = [[UILabel alloc]initWithFrame:CGRectMake(14, 0, 74, 24)];
                goodsDetailLable.textColor = [UIColor blackColor];
                goodsDetailLable.text = @"商品详情";
                UILabel *goodsCoding = [[UILabel alloc]initWithFrame:CGRectMake(172,3
                                                                                , 120,22)];
                goodsCoding.text = @"商品编码";
                goodsCoding.font = [UIFont systemFontOfSize:12];
                goodsCoding.textColor = [UIColor grayColor];
                [cell addSubview:goodsCoding];
                [cell addSubview:goodsDetailLable];
                [cell addSubview:self.goodsDetailTableView];
            }
            return  cell;
        }
    }else
    {
        if(indexPath.section ==0)
        {
            //section上半部分
            if(indexPath.row == 1)
            {
                static NSString *identifier = @"goodsintro1";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if(cell == nil)
                {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                }
                return cell;
            }else{
                static NSString *identifier = @"goodsintro2";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if(cell == nil)
                {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                }
                return cell;
            }
        }else if(indexPath.section == 1){
            static NSString *identifier = @"bottomCell1";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if(cell == nil)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            return cell;
        }else{
            static NSString *identifier = @"bottomCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if(cell == nil)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            return cell;
        }

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
    NSLog(@"%i",[sender tag]);
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

//为向左移动小箭头绑定事件
-(void)leftMoveBtnPressed:(id)sender
{
    int offsetWidth = self.goodsImageScrollView.contentOffset.x;
    if((offsetWidth == 258)||(offsetWidth < 258))
    {
        [self.goodsImageScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else{
        [self.goodsImageScrollView setContentOffset:CGPointMake(offsetWidth-258, 0) animated:YES];
    }
}

//为向右移动小箭头绑定事件
-(void)rightMoveBtnPressed:(id)sender
{
    int offsetWidth = self.goodsImageScrollView.contentOffset.x;
    int offsetRetain = self.goodsImageScrollView.contentSize.width-offsetWidth;
    if((offsetRetain == 258)||(offsetRetain < 258))
    {
        [self.goodsImageScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else{
        [self.goodsImageScrollView setContentOffset:CGPointMake(offsetWidth+258, 0) animated:YES];
    }   
}
@end
