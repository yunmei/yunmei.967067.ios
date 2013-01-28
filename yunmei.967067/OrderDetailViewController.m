//
//  OrderDetailViewController.m
//  yunmei.967067
//
//  Created by ken on 13-1-18.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import "OrderDetailViewController.h"

@interface OrderDetailViewController ()

@end

@implementation OrderDetailViewController
@synthesize orderDetailTableView;
@synthesize orderData;
@synthesize rootScrollView;
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
    CGFloat height = 380+[[self.orderData objectForKey:@"goods"] count]*110;
    self.rootScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 366)];
    self.rootScrollView.scrollEnabled = YES;
    [self.rootScrollView setContentSize:CGSizeMake(320, height+60)];
    [self.view addSubview:self.rootScrollView];
    // Do any additional setup after loading the view from its nib.
    self.orderDetailTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, height) style:UITableViewStyleGrouped];
    [self.orderDetailTableView setBackgroundView:nil];
    self.orderDetailTableView.scrollEnabled = NO;
    self.orderDetailTableView.delegate = self;
    self.orderDetailTableView.dataSource = self;
    [self.orderDetailTableView setBackgroundColor:[UIColor clearColor]];
    [self.rootScrollView addSubview:self.orderDetailTableView];
    if([[self.orderData objectForKey:@"pay_status"] isEqualToString:@"0"])
    {
        UILabel *payCountLable = [[UILabel alloc]initWithFrame:CGRectMake(170, height, 140, 20)];
        [payCountLable setTextColor:[UIColor redColor]];
        [payCountLable setText:[NSString stringWithFormat:@"订单总金额 : ￥%@",[self.orderData objectForKey:@"final_amount"]]];
        [payCountLable setFont:[UIFont systemFontOfSize:12.0]];
        UIButton *payRightNowBtn = [[UIButton alloc]initWithFrame:CGRectMake(240, height+30, 60, 30)];
        [payRightNowBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        [payRightNowBtn setBackgroundImage:[UIImage imageNamed:@"btn_yellow"] forState:UIControlStateNormal];
        payRightNowBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [payRightNowBtn addTarget:self action:@selector(buyNow:) forControlEvents:UIControlEventTouchUpInside];
        [self.rootScrollView addSubview:payCountLable];
        [self.rootScrollView addSubview:payRightNowBtn];
   }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload {
    [self setOrderDetailTableView:nil];
    [self setOrderDetailTableView:nil];
    [self setRootScrollView:nil];
    [super viewDidUnload];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 3)
    {
        NSMutableArray *goodsArr = [self.orderData objectForKey:@"goods"];
        return [goodsArr count];
    }else if (section == 4){
        return 2;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section ==0)
    {
        return 80;
    }else if (indexPath.section ==1){
        return 30;
    }else if (indexPath.section ==2){
        return 90;
    }else if (indexPath.section ==3){
        return 110;
    }else{
        return 40;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section ==0){
        //订单号
        UILabel *orderIdLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 250, 20)];
        [orderIdLable setText:[NSString stringWithFormat:@"订单号 : %@",[self.orderData objectForKey:@"orderId"]]];
        [orderIdLable setFont:[UIFont systemFontOfSize:12.0]];
        //订单金额
        UILabel *payLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 250, 20)];
        [payLable setText:[NSString stringWithFormat:@"订单金额 : ￥%@",[self.orderData objectForKey:@"final_amount"]]];
        [payLable setFont:[UIFont systemFontOfSize:12.0]];
        [payLable setTextColor:[UIColor redColor]];
        //下单日期
        UILabel *createtimeLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 250, 20)];
        [createtimeLable setText:[NSString stringWithFormat:@"下单日期 : %@",[self.orderData objectForKey:@"createtime"]]];
        [createtimeLable setFont:[UIFont systemFontOfSize:12.0]];
        static NSString *identifier = @"firstCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [orderIdLable setBackgroundColor:[UIColor clearColor]];
            [payLable setBackgroundColor:[UIColor clearColor]];
            [createtimeLable setBackgroundColor:[UIColor clearColor]];
            [cell addSubview:orderIdLable];
            [cell addSubview:payLable];
            [cell addSubview:createtimeLable];
        }

        return cell;
    }else if (indexPath.section ==1){
        static NSString *identifier = @"secondCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell ==nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                 cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UILabel *statusLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 200, 20)];
            [statusLable setFont:[UIFont systemFontOfSize:14.0]];
            if([[self.orderData objectForKey:@"pay_status"]isEqualToString:@"0"])
            {
                [statusLable setText:[NSString stringWithFormat:@"订单状态 : 未支付"]];
                [statusLable setTextColor:[UIColor redColor]];
            }else{
                [statusLable setText:[NSString stringWithFormat:@"订单状态 : 已支付"]];
                [statusLable setTextColor:[UIColor blackColor]];
            }
            [statusLable setBackgroundColor:[UIColor clearColor]];
            [cell addSubview:statusLable];
        }

        return cell;
    }else if (indexPath.section == 2){
        UILabel *addressInfoStringLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 100, 20)];
        [addressInfoStringLable setText:@"收货信息"];
        [addressInfoStringLable setFont:[UIFont systemFontOfSize:14.0]];
        //详细地址
        UILabel *addressInDetailLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 25, 260, 20)];
        [addressInDetailLable setFont:[UIFont systemFontOfSize:12.0]];
        [addressInDetailLable setText:[NSString stringWithFormat:@"详细地址 : %@",[self.orderData objectForKey:@"ship_addr"]]];
        //收货人
        UILabel *shipNameLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 45, 260, 20)];
        [shipNameLable setFont:[UIFont systemFontOfSize:12.0]];
        [shipNameLable setText:[NSString stringWithFormat:@"收货人 : %@",[self.orderData objectForKey:@"ship_name"]]];
        //联系电话
        UILabel *telephoneLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 65, 260, 20)];
        [telephoneLable setFont:[UIFont systemFontOfSize:12.0]];
        [telephoneLable setText:[NSString stringWithFormat:@"联系电话 : %@",[self.orderData objectForKey:@"ship_mobile"]]];
        static NSString *identifier = @"thirdCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell ==nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [addressInfoStringLable setBackgroundColor:[UIColor clearColor]];
            [addressInDetailLable setBackgroundColor:[UIColor clearColor]];
            [shipNameLable setBackgroundColor:[UIColor clearColor]];
            [telephoneLable setBackgroundColor:[UIColor clearColor]];
            [cell addSubview:addressInfoStringLable];
            [cell addSubview:addressInDetailLable];
            [cell addSubview:shipNameLable];
            [cell addSubview:telephoneLable];
        }

        return cell;
    }else if (indexPath.section ==3){
        static NSString *identifier = @"goodsInfo";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSMutableArray *goodsArr = [self.orderData objectForKey:@"goods"];
            UIImageView *goodsImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 80, 80)];
            [goodsImg setImage:[UIImage imageNamed:@"goods_default"]];
            [YMGlobal loadImage:[[goodsArr objectAtIndex:indexPath.row] objectForKey:@"imageUrl"]  andImageView:goodsImg];
            //商品名称
            UILabel *goodsNameLable = [[UILabel alloc]initWithFrame:CGRectMake(100, 15, 200, 40)];
            [goodsNameLable setFont:[UIFont systemFontOfSize:15.0]];
            [goodsNameLable setText:[NSString stringWithFormat:@"%@",[[goodsArr objectAtIndex:indexPath.row] objectForKey:@"name"]]];
            [goodsNameLable setNumberOfLines:0];
            //商品编号
            UILabel *goodsCodeLable = [[UILabel alloc]initWithFrame:CGRectMake(100, 55, 200, 20)];
            [goodsCodeLable setFont:[UIFont systemFontOfSize:12.0]];
            [goodsCodeLable setText:[NSString stringWithFormat:@"商品编号 : %@",[[goodsArr objectAtIndex:indexPath.row] objectForKey:@"bn"]]];
            //商品价格数量
            UILabel *goodsPriceLable = [[UILabel alloc]initWithFrame:CGRectMake(100, 75, 200, 20)];
            [goodsPriceLable setFont:[UIFont systemFontOfSize:12.0]];
            [goodsPriceLable setText:[NSString stringWithFormat:@"价格 : ￥%@     数量 : %@",[[goodsArr objectAtIndex:indexPath.row] objectForKey:@"price"],[[goodsArr objectAtIndex:indexPath.row] objectForKey:@"nums"]]];
            [goodsPriceLable setTextColor:[UIColor redColor]];
            [goodsNameLable setBackgroundColor:[UIColor clearColor]];
            [goodsCodeLable setBackgroundColor:[UIColor clearColor]];
            [goodsPriceLable setBackgroundColor:[UIColor clearColor]];
            [cell addSubview:goodsImg];
            [cell addSubview:goodsNameLable];
            [cell addSubview:goodsCodeLable];
            [cell addSubview:goodsPriceLable];
        }

        return cell;
    }else{
        if(indexPath.row == 0)
        {
            static NSString *identifier = @"payStyle";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if(cell == nil)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UILabel *payLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 250, 20)];
                [payLable setFont:[UIFont systemFontOfSize:12.0]];
                [payLable setText:[NSString stringWithFormat:@"支付方式 : %@",[self.orderData objectForKey:@"custom_name"]]];
                [payLable setBackgroundColor:[UIColor clearColor]];
                [cell addSubview:payLable];
            }
            return cell;
        }else{
            static NSString *identifier = @"shipStyle";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if(cell == nil)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UILabel *shipLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 250, 20)];
                [shipLable setFont:[UIFont systemFontOfSize:12.0]];
                [shipLable setText:[NSString stringWithFormat:@"配送方式 : %@",[self.orderData objectForKey:@"shipping"]]];
                [shipLable setBackgroundColor:[UIColor clearColor]];
                [cell addSubview:shipLable];
            }

            return cell;
        }

    }
}


-(void)buyNow:(id)sender
{
    NSString *orderId = [self.orderData objectForKey:@"orderId"];
    NSLog(@"orderid%@",orderId);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
