//
//  GoodsModel.m
//  yunmei.967067
//
//  Created by bevin chen on 12-11-29.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel

@synthesize goodsId;
@synthesize goodsPrice;
@synthesize goodsName;
@synthesize imageUrl;
@synthesize goodsCode;
@synthesize goodsMarketPrice;
@synthesize store;
@synthesize standard;
@synthesize property = _property;
@synthesize proId = _proId;
@synthesize buyCount;

-(NSString *)proId
{
    if(_proId == nil)
    {
        _proId = @"0";
    }
    return _proId;
}
-(NSMutableDictionary *)property
{
    if(_property == nil)
    {
        _property = [[NSMutableDictionary alloc]init];
    }
    return _property;
}

//创建表goodslist_car
+(void)creatTable
{
    YMDbClass *db = [[YMDbClass alloc]init];
    if([db connect])
    {
        [db exec:@"CREATE TABLE IF NOT EXISTS goodslist_car('goodsid','goods_code','goods_name','goods_price','goods_store','proid' ,'goods_count');"];
        [db close];
    }
}

//加入购物车
+(void)AddCar:(GoodsModel *)goodsItem
{
    YMDbClass *db = [[YMDbClass alloc]init];
    if([db connect])
    {
        NSString *querysql = [NSString stringWithFormat:@"goodslist_car where goodsid = '%@' and proid = '%@';",goodsItem.goodsId,goodsItem.proId];
        NSString *resultCount = [db count:querysql];
        if([resultCount isEqualToString:@"0"])
        {
            querysql = [NSString stringWithFormat:@"INSERT INTO goodslist_car (goodsid,goods_code,goods_name,goods_price,goods_store,proid,goods_count)VALUES('%@','%@','%@','%@','%@','%@','%i');",goodsItem.goodsId,goodsItem.goodsCode,goodsItem.goodsName,goodsItem.goodsPrice,goodsItem.store,goodsItem.proId,goodsItem.buyCount];
        }else{
            NSLog(@"houlaijiaru");
            querysql = [NSString stringWithFormat:@"UPDATE goodslist_car SET goods_count = goods_count+'%i' WHERE goodsid = '%@' and proid = '%@';",goodsItem.buyCount,goodsItem.goodsId,goodsItem.proId];
        }

        [db exec:querysql];
        [db close];
    }
}
@end
