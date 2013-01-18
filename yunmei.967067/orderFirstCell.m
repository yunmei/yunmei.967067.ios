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
@synthesize trackOrderBtn = _trackOrderBtn;
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
        _orderCode = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 200, 15)];
    }
    [_orderCode setFont:[UIFont systemFontOfSize:12.0]];
    return _orderCode;
}

-(UILabel *)orderPay
{
    if(_orderPay == nil)
    {
        _orderPay = [[UILabel alloc]initWithFrame:CGRectMake(20, 26, 200, 15)];
    }
    [_orderPay setFont:[UIFont systemFontOfSize:12.0]];
    [_orderPay setTextColor:[UIColor redColor]];
    return _orderPay;
}

-(UILabel *)orderGenerateTime
{
    if(_orderGenerateTime == nil)
    {
        _orderGenerateTime = [[UILabel alloc]initWithFrame:CGRectMake(20, 44, 250, 15)];
    }
    [_orderGenerateTime setFont:[UIFont systemFontOfSize:12.0]];
    return _orderGenerateTime;
}

-(UIButton *)trackOrderBtn
{
    if(_trackOrderBtn == nil)
    {
        _trackOrderBtn = [[UIButton alloc]initWithFrame:CGRectMake(230, 20, 60, 30)];
    }
    [_trackOrderBtn setBackgroundImage:[UIImage imageNamed:@"btn_yellow"] forState:UIControlStateNormal];
    [_trackOrderBtn setTitle:@"订单追踪" forState:UIControlStateNormal];
    _trackOrderBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    return  _trackOrderBtn;
}
@end
