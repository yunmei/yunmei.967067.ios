//
//  CarCell.h
//  yunmei.967067
//
//  Created by ken on 12-12-29.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CarCell : UITableViewCell

@property(strong,nonatomic)UILabel *goodsName;
@property(strong,nonatomic)UILabel *goodsCode;
@property(strong,nonatomic)UITextField *buyCount;
@property(strong,nonatomic)UILabel *goodsPrice;
@end
