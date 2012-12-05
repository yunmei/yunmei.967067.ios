//
//  CategorySecViewController.h
//  yunmei.967067
//
//  Created by ken on 12-12-1.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategorySecViewController : UIViewController<UITableViewDelegate,
    UITableViewDataSource
>
@property (strong, nonatomic) IBOutlet UITableView *categorySectableView;
@property (strong, nonatomic) NSMutableArray * subCateList;
@end
