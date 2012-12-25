//
//  CategoryThirdViewController.h
//  yunmei.967067
//
//  Created by ken on 12-12-20.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsListViewController.h"

@interface CategoryThirdViewController : UIViewController<
    UITableViewDataSource,
    UITableViewDelegate
>



@property (strong, nonatomic) IBOutlet UITableView *thirdSubCatTableView;
@property(strong,nonatomic)NSMutableArray *thirdSubCatArr;
@end
