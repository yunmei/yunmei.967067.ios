//
//  OrderEditViewController.h
//  yunmei.967067
//
//  Created by ken on 13-1-8.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMDbClass.h"
#import "goodsInfoView.h"

@interface OrderEditViewController : UIViewController<
UITableViewDataSource,
UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *orderTableView;
@property (strong,nonatomic)NSMutableArray *goodsInfoList;

@end
