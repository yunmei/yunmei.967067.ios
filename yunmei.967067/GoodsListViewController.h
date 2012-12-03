//
//  GoodsListViewController.h
//  yunmei.967067
//
//  Created by bevin chen on 12-11-8.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullToRefreshTableView.h"

@interface GoodsListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *goodsList;
@property (strong, nonatomic) NSString *requestDataType;
@property (strong, nonatomic) NSString *requestId;
@property (strong, nonatomic) PullToRefreshTableView *refreshTableView;

@end
