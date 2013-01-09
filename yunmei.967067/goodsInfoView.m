//
//  goodsInfoView.m
//  yunmei.967067
//
//  Created by ken on 13-1-8.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import "goodsInfoView.h"

@implementation goodsInfoView
@synthesize goodsName = _goodsName;
@synthesize codeString = _codeString;
@synthesize codeNumber = _codeNumber;
@synthesize goodsCountString = _goodsCountString;
@synthesize goodsCount = _goodsCount;
@synthesize totalPrice = _totalPrice;
@synthesize totalPriceString = _totalPriceString;
@synthesize height;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(UILabel *)goodsName
{
    if(_goodsName == nil)
    {
        _goodsName = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 320, 30)];
    }
    _goodsName.numberOfLines = 0;
    _goodsName.backgroundColor = [UIColor clearColor];
    _goodsName.font = [UIFont systemFontOfSize:12.0];
    return  _goodsName;
}

-(UILabel *)codeString
{
    if(_codeString == nil)
    {
        _codeString = [[UILabel alloc]initWithFrame:CGRectMake(5, 33, 50, 20)];
    }
    _codeString.numberOfLines = 0;
    _codeString.backgroundColor = [UIColor clearColor];
    _codeString.font = [UIFont systemFontOfSize:11.0];
    _codeString.textColor = [UIColor grayColor];
    _codeString.text = @"商品编码:";
    return  _codeString;
}

-(UILabel *)codeNumber
{
    if(_codeNumber == nil)
    {
        _codeNumber = [[UILabel alloc]initWithFrame:CGRectMake(60, 33, 100, 20)];
    }
    _codeNumber.numberOfLines = 0;
    _codeNumber.backgroundColor = [UIColor clearColor];
    _codeNumber.font = [UIFont systemFontOfSize:11.0];
    _codeNumber.textColor = [UIColor grayColor];
    return  _codeNumber;
}

-(UILabel *)goodsCountString
{
    if(_goodsCountString == nil)
    {
        _goodsCountString = [[UILabel alloc]initWithFrame:CGRectMake(5, 55, 30, 20)];
    }
    _goodsCountString.numberOfLines = 0;
    _goodsCountString.backgroundColor = [UIColor clearColor];
    _goodsCountString.font = [UIFont systemFontOfSize:11.0];
    _goodsCountString.textColor = [UIColor grayColor];
    _goodsCountString.text = @"数量:";
    return  _goodsCountString;
}

-(UILabel *)goodsCount
{
    if(_goodsCount == nil)
    {
        _goodsCount = [[UILabel alloc]initWithFrame:CGRectMake(36, 55, 50, 20)];
    }
    _goodsCount.backgroundColor = [UIColor clearColor];
    _goodsCount.font = [UIFont systemFontOfSize:11.0];
    _goodsCount.textColor = [UIColor redColor];
    return  _goodsCount;
}

-(UILabel *)totalPriceString
{
    if(_totalPriceString == nil)
    {
        _totalPriceString = [[UILabel alloc]initWithFrame:CGRectMake(70, 55, 30, 20)];
    }
    _totalPriceString.numberOfLines = 0;
    _totalPriceString.backgroundColor = [UIColor clearColor];
    _totalPriceString.font = [UIFont systemFontOfSize:11.0];
    _totalPriceString.textColor = [UIColor grayColor];
    _totalPriceString.text = @"共计:";
    return  _totalPriceString;
}

-(UILabel *)totalPrice
{
    if(_totalPrice == nil)
    {
        _totalPrice = [[UILabel alloc]initWithFrame:CGRectMake(100, 55, 100, 20)];
    }
    _totalPrice.backgroundColor = [UIColor clearColor];
    _totalPrice.font = [UIFont systemFontOfSize:11.0];
    _totalPrice.textColor = [UIColor redColor];
    return  _totalPrice;
}

-(void)addChild
{
    [self addSubview:self.goodsName];
    [self addSubview:self.codeString];
    [self addSubview:self.codeNumber];
    [self addSubview:self.goodsCountString];
    [self addSubview:self.goodsCount];
    [self addSubview:self.totalPriceString];
    [self addSubview:self.totalPrice];
}
@end
