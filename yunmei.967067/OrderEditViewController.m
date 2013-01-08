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
    [self.orderTableView reloadData];
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
        return 30+self.goodsInfoList.count*50;
    }else{
        return 80.0;
    }  
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
////    static NSString *identifier = @"identifier";
////    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
////    if(cell == nil)
////    {
////        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
////    }
//    return cell;
    if(indexPath.row == 1)
    {
        static NSString *identifier = @"info";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            UILabel *infoString = [[UILabel alloc]initWithFrame:CGRectMake(3, 5, 80, 25)];
            infoString.text = @"商品信息";
            [cell addSubview:infoString];
        }else{
            int i =1;
            for(NSMutableDictionary *o in self.goodsInfoList)
            {
                NSMutableDictionary *goodsDic = o;
                UIView *goodsSubView = [[UIView alloc]initWithFrame:CGRectMake(3, 30+i*40, 160, 40)];
                UILabel *goodsName = [[UILabel alloc]initWithFrame:CGRectMake(3, 30, 150, 10)];
                [goodsName setText:[goodsDic objectForKey:@"goods_name"]];
                goodsName setFont:[[UIFont systemFontOfSize:12.0]];
                
                [goodsSubView addSubview:goodsName];
                [cell addSubview:goodsSubView];
                i++;
            }
        }
        
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
