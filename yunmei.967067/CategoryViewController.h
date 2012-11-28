//
//  CategoryViewController.h
//  yunmei.967067
//
//  Created by bevin chen on 12-11-2.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"
#import "YMGlobal.h"
#import "YMGlobal.h"
#import "AppDelegate.h"
@interface CategoryViewController : UIViewController<
    UITableViewDataSource,
    UITableViewDelegate
>

@property (strong, nonatomic)NSMutableArray *catItemList;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
