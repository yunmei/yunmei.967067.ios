//
//  IndexViewController.h
//  yunmei.967067
//
//  Created by bevin chen on 12-11-2.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdModel.h"
#import "GoodsInfoViewController.h"
#import "ZBarSDK.h"
#import "GoodsInfoViewController.h"
@interface IndexViewController : UIViewController <UIScrollViewDelegate, ZBarReaderDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *adScrollView;
@property (strong, nonatomic) IBOutlet UIView *searchBgView;
@property (strong, nonatomic) IBOutlet UIView *imageAdView;
@property (strong, nonatomic) IBOutlet UIView *goodsListView;
@property (strong, nonatomic) NSMutableArray *adList;
@property (strong, nonatomic) IBOutlet UIView *adPageView;
@property (strong, nonatomic) UIView *adPageProgressView;
@property (strong, nonatomic) NSMutableArray *goodsList;

// 展示广告列表
- (void)showAdList;
// 设置广告分页
- (void)setAdPage:(float)page countPage:(float)countPage;
// 展示推荐列表
- (void)showGoodsList;
@end
