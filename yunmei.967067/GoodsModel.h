//
//  GoodsModel.h
//  yunmei.967067
//
//  Created by bevin chen on 12-11-29.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMDbClass.h"

@interface GoodsModel : NSObject

@property(strong, nonatomic)NSString *goodsId;
@property(strong, nonatomic)NSString *goodsPrice;
@property(strong, nonatomic)NSString *goodsName;
@property(strong, nonatomic)NSString *imageUrl;
@property(strong, nonatomic)NSString *goodsCode;
@property(strong, nonatomic)NSString *goodsMarketPrice;
@property(strong, nonatomic)NSString *store;
@property(strong, nonatomic)NSString *standard;
@property(strong, nonatomic)NSMutableDictionary *property;
@property(strong,nonatomic)NSString *proId;
@property(assign,nonatomic)NSInteger buyCount;

+(void)creatTable;
+(void)AddCar:(GoodsModel*)goodsItem;
@end
