//
//  YMGlobal.m
//  yunmei.967067
//
//  Created by bevin chen on 12-11-13.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "YMGlobal.h"
#import "Constants.h"
#import "AppDelegate.h"

@implementation YMGlobal

+ (MKNetworkOperation *)getOperation:(NSMutableDictionary *)params
{
    [params setObject:@"2" forKey:@"return_data"];
    [params setObject:@"2.0" forKey:@"api_version"];
    return [ApplicationDelegate.appEngine operationWithPath:API_BASEURL params:params httpMethod:API_METHOD ssl:NO];
}
@end
