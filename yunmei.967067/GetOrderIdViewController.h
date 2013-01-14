//
//  GetOrderIdViewController.h
//  yunmei.967067
//
//  Created by ken on 13-1-14.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetOrderIdViewController : UIViewController
@property(strong,nonatomic)NSString *orderId;
@property BOOL payOnline;
@property(strong,nonatomic)NSMutableDictionary *orderParamsDic;
@end
