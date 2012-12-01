//
//  GoodsCell.m
//  yunmei.967067
//
//  Created by bevin chen on 12-11-30.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "GoodsCell.h"

@interface GoodsCell ()

@end

@implementation GoodsCell

@synthesize goodsImageView;
@synthesize goodsNameLabel;
@synthesize goodsPriceLabel;

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
@end
