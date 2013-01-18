//
//  orderSecondCell.m
//  yunmei.967067
//
//  Created by ken on 13-1-18.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import "orderSecondCell.h"

@implementation orderSecondCell
@synthesize goodsImg = _goodsImg;
@synthesize goodsName = _goodsName;
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

-(UIImageView *)goodsImg
{
    if(_goodsImg == nil)
    {
        _goodsImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 80)];
    }
    return _goodsImg;
}

-(UILabel *)goodsName
{
    if(_goodsName == nil)
    {
        _goodsName = [[UILabel alloc]initWithFrame:CGRectMake(100, 2, 220, 40)];
    }
    [_goodsName setFont:[UIFont systemFontOfSize:17.0]];
    return _goodsName;
}
@end
