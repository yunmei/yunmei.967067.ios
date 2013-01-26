//
//  TrackOrderViewController.h
//  yunmei.967067
//
//  Created by ken on 13-1-26.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetOrderListViewController.h"
@interface TrackOrderViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *trackOrderTableView;
@property(strong,nonatomic) NSString *logi_name;
@property(strong,nonatomic) NSString *logi_code;
@property(strong,nonatomic) NSString *logi_no;
@property(strong,nonatomic)NSMutableArray *trackData;
@end
