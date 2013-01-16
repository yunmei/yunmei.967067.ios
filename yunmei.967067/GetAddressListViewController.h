//
//  GetAddressListViewController.h
//  yunmei.967067
//
//  Created by ken on 13-1-15.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderEditViewController.h"
#import "PassValueDelegate.h"
#import "AddAddressViewController.h"
@interface GetAddressListViewController : UIViewController<
UITableViewDelegate,
UITableViewDataSource
>
@property (strong, nonatomic) IBOutlet UITableView *AddressListTableView;
@property(strong,nonatomic)NSMutableArray *userAddressArr;
@property(strong,nonatomic)NSString *selectedAddrId;
//这里用assign而不用retain是为了防止引起循环引用。
@property(assign)NSObject<PassValueDelegate> *delegate;
@end
