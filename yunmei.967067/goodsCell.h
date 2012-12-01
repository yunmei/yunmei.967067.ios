//
//  GoodsCell.h
//  yunmei.967067
//
//  Created by bevin chen on 12-11-30.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (strong, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *goodsPriceLabel;
@end
