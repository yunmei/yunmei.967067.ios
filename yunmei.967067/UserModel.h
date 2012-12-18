//
//  UserModel.h
//  yunmei.967067
//
//  Created by bevin chen on 12-12-18.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMDbClass.h"

@interface UserModel : NSObject

@property(strong,nonatomic)NSString *userid;
@property(strong,nonatomic)NSString *username;
@property(strong,nonatomic)NSString *password;
@property(strong,nonatomic)NSString *session;
@property(strong,nonatomic)NSString *isLogin;

// 检查是否登陆
+ (BOOL)checkLogin;
// 用户退出
+ (void)logout;
// 获取用户信息
+ (UserModel *)getUserModel;
// sqlite上创建用户表
+ (void)createTable;
// sqlite上清除用户表
+ (void)clearTable;

@end
