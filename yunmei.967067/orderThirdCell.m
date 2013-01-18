//
//  orderThirdCell.m
//  yunmei.967067
//
//  Created by ken on 13-1-18.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import "orderThirdCell.h"

@implementation orderThirdCell
@synthesize orderState = _orderState;
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

-(UILabel *)orderState
{
    if(_orderState == nil)
    {
        _orderState = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 200, 20)];
    }
    
    [_orderState setFont:[UIFont systemFontOfSize:12.0]];
    [_orderState setTextColor:[UIColor redColor]];
    return _orderState;
}
@end
