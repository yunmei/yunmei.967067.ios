//
//  CategoryCell.m
//  yunmei.967067
//
//  Created by ken on 12-11-29.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell

@synthesize categoryName = _categoryName;
@synthesize catDesc = _catDesc;
@synthesize catImageView = _catImageView;


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
-(UILabel *)categoryName
{
    if(_categoryName==nil)
    {
        _categoryName.backgroundColor=[UIColor clearColor];
    }
    return  _categoryName;
}
@end
