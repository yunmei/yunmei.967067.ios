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



-(NSMutableDictionary *)property
{
    if(_property == nil)
    {
        _property = [[NSMutableDictionary alloc]init];
    }
    return _property;
}
@end
