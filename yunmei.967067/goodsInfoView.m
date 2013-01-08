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

@end
