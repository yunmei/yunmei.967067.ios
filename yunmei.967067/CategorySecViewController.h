//
//  CategorySecViewController.h
//  yunmei.967067
//
//  Created by ken on 12-12-1.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryThirdViewController.h"
#import "MBProgressHUD.h"
#import "CategoryModel.h"
#import "SBJson.h"
#import "YMGlobal.h"
#import "AppDelegate.h"

@interface CategorySecViewController : UIViewController<UITableViewDelegate,
    UITableViewDataSource
>
@property (strong, nonatomic) IBOutlet UITableView *categorySectableView;
@property (strong, nonatomic) NSMutableArray * subCateList;
@end
