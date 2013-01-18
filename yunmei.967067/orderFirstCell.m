//
//  orderFirstCell.m
//  yunmei.967067
//
//  Created by ken on 13-1-18.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import "orderFirstCell.h"

@implementation orderFirstCell
@synthesize orderCode = _orderCode;
@synthesize orderPay = _orderPay;
@synthesize orderGenerateTime = _orderGenerateTime;
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

-(UILabel *)orderCode
{
    if(_orderCode == nil)
    {
        _orderCode = [[UILabel alloc]initWithFrame:CGRectMake(3, 0, 200, 20)];
    }
    [_orderCode setFont:[UIFont systemFontOfSize:12.0]];
    return _orderCode;
}

-(UILabel *)orderPay
{
    if(_orderPay == nil)
    {
        _orderPay = [[UILabel alloc]initWithFrame:CGRectMake(3, 20, 200, 20)];
    }
    [_orderPay setFont:[UIFont systemFontOfSize:12.0]];
    [_orderPay setTextColor:[UIColor redColor]];
    return _orderPay;
}

-(UILabel *)orderGenerateTime
{
    if(_orderGenerateTime == nil)
    {
        _orderGenerateTime = [[UILabel alloc]initWithFrame:CGRectMake(3, 40, 250, 20)];
    }
    [_orderGenerateTime setFont:[UIFont systemFontOfSize:12.0]];
    return _orderGenerateTime;
}
@end
