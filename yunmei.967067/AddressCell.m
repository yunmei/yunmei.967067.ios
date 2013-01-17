//
//  AddressCell.m
//  yunmei.967067
//
//  Created by ken on 13-1-17.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import "AddressCell.h"

@implementation AddressCell
@synthesize selectedLog = _selectedLog;
@synthesize addrLable = _addrLable;
@synthesize nameLable = _nameLable;
@synthesize zipLable = _zipLable;

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

-(UIImageView *)selectedLog
{
    if(_selectedLog == nil)
    {
        _selectedLog = [[UIImageView alloc]initWithFrame:CGRectMake(3, 40, 20, 20)];
    }
    [_selectedLog setImage:[UIImage imageNamed:@"RadioButton-Unselected"]];
    return _selectedLog;
}

-(UILabel *)nameLable
{
    if(_nameLable == nil)
    {
        _nameLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 37, 270, 30)];
    }
    return _nameLable;
}

-(UILabel *)addrLable
{
    if(_addrLable == nil)
    {
        _addrLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 5, 270, 30)];
    }
    return _addrLable;
}

-(UILabel *)zipLable
{
    if(_zipLable == nil)
    {
        _zipLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 70, 270, 30)];
    }
    return _zipLable;
}
@end
