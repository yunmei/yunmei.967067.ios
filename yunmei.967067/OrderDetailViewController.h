//
//  OrderDetailViewController.h
//  yunmei.967067
//
//  Created by ken on 13-1-18.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMGlobal.h"
#import "AlixPayViewController.h"
@interface OrderDetailViewController : UIViewController<
UITableViewDataSource,
UITableViewDelegate,
UIScrollViewDelegate
>
@property (strong, nonatomic) UIScrollView *rootScrollView;

@property (strong, nonatomic)  UITableView *orderDetailTableView;

@property(strong,nonatomic)NSMutableDictionary *orderData;
@end
