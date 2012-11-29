//
//  CategoryCell.h
//  yunmei.967067
//
//  Created by ken on 12-11-29.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *categoryName;
@property (strong, nonatomic) IBOutlet UIImageView *categoryImageView;
@property (strong, nonatomic) IBOutlet UILabel *categoryDiscription;

@end
