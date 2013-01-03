//
//  CarCell.m
//  yunmei.967067
//
//  Created by ken on 12-12-29.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "CarCell.h"

@implementation CarCell
@synthesize goodsCode = _goodsCode;
@synthesize goodsName = _goodsName;
@synthesize goodsPrice = _goodsPrice;
@synthesize buyCount = _buyCount;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(UILabel *)goodsName
{
    if(_goodsName == nil)
    {
        _goodsName = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 300, 30)];
    }
   return  _goodsName;
}
-(UILabel *)goodsCode
{
    if(_goodsCode == nil)
    {
        _goodsCode = [[UILabel alloc]initWithFrame:CGRectMake(68, 36, 200, 30)];
        [_goodsCode setFont:[UIFont systemFontOfSize:13.0]];
    }
    return  _goodsCode;
}
-(UILabel *)goodsPrice
{
    if(_goodsPrice == nil)
    {
        _goodsPrice = [[UILabel alloc]initWithFrame:CGRectMake(45, 65, 100, 30)];
        [_goodsPrice setFont:[UIFont systemFontOfSize:13.0]];
        [_goodsPrice setTextColor:[UIColor redColor]];
    }
    return  _goodsPrice;
}
-(UITextField *)buyCount
{
    if(_buyCount == nil)
    {
        _buyCount = [[UITextField alloc]initWithFrame:CGRectMake(180, 68, 60, 25)];
        [_buyCount setFont:[UIFont systemFontOfSize:13.0]];
        //设置内容水平垂直居中
        [_buyCount setTextAlignment:UITextAlignmentCenter];
        [_buyCount setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_buyCount setKeyboardType:UIKeyboardTypeNumberPad];
        [_buyCount setEnabled:NO];


    }
    return  _buyCount;
}

@end
