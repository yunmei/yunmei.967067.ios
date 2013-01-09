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
    }else{
        return 80.0;
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
                [cell addSubview:goodsSubView];
            }
            
        return cell;
    }else{
        static NSString *identifier = @"identifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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

@end
