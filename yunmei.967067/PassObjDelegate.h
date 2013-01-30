//
//  PayStatus.h
//  yunmei.967067
//
//  Created by ken on 13-1-30.
//  Copyright (c) 2013年 bevin chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PayStatus <NSObject>

-(void)checkPayStatus:(BOOL)IsUserPay;
@end
