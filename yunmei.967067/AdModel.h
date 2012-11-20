//
//  AdModel.h
//  yunmei.967067
//
//  Created by bevin chen on 12-11-13.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdModel : NSObject

@property NSUInteger adid;
@property(strong,nonatomic)NSString *imageUrl;
@property(strong,nonatomic)NSString *goodsIds;
@property(strong,nonatomic)UIImage *image;
@property(strong,nonatomic)NSString *desc;
@end
