//
//  UserModel.m
//  yunmei.967067
//
//  Created by bevin chen on 12-12-18.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

@synthesize userid;
@synthesize username;
@synthesize password;
@synthesize session;
@synthesize isLogin;

+ (BOOL)checkLogin
{
    UserModel *userModel = [UserModel getUserModel];
    if ([userModel.isLogin isEqualToString:@"YES"] && userModel.session && userModel.userid) {
        return true;
    } else {
        return false;
    }
}

+ (void)logout
{
    [UserModel clearTable];
}

+ (UserModel *)getUserModel
{
    UserModel *userModel = [[UserModel alloc]init];
    YMDbClass *db = [[YMDbClass alloc]init];
    if([db connect])
    {
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
        dictionary = [db fetchOne:@"select * from user"];
        userModel.userid = [dictionary objectForKey:@"user_id"];
        userModel.username = [dictionary objectForKey:@"username"];
        userModel.password = [dictionary objectForKey:@"password"];
        userModel.isLogin = [dictionary objectForKey:@"is_login"];
        userModel.session = [dictionary objectForKey:@"session"];
        [db close];
    }
    return userModel;
}

+ (void)createTable
{
    YMDbClass *db = [[YMDbClass alloc]init];
    if([db connect])
    {
        [db exec:@"CREATE TABLE IF NOT EXISTS user ('user_id', 'username', 'password', 'is_login', 'session');"];
        [db exec:@"CREATE TABLE IF NOT EXISTS user_address ('user_id', 'addr', 'addr_id', 'city', 'city_id','district','district_id','is_default','mobile','name','province','province_id','telphone','zip');"];
        [db close];
    }
}

+(void)createAddressTable
{
    YMDbClass *db = [[YMDbClass alloc]init];
    if([db connect])
    {
        [db exec:@"CREATE TABLE IF NOT EXISTS user_address ('user_id', 'addr', 'addr_id', 'city', 'city_id','district','district_id','is_default','mobile','name','province','province_id','telphone','zip');"];
        [db exec:@"DELETE FROM user_address"];
        [db close];
    }
}

+ (void)clearTable
{
    YMDbClass *db = [[YMDbClass alloc]init];
    if([db connect])
    {
        [db exec:@"delete from user;"];
        [db exec:@"delete from  user_address"];
        [db close];
    }
}

@end
